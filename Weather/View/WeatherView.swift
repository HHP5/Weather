//
//  WeatherView.swift
//  Weather
//
//  Created by Екатерина Григорьева on 28.04.2021.
//

import UIKit
import SnapKit
import Kingfisher

class WeatherView: UIView {
	
	// MARK: - Properties
	
	var weatherInfo: WeatherInfo? {
		willSet(weatherInfo) {
			guard let weatherInfo = weatherInfo else { return }
			
			locality.text = weatherInfo.locality
			weatherDescriprion.text = weatherInfo.weatherDescriprion
			mainWeatherImage.image = weatherInfo.mainWeatherImage
			weatherIcon.kf.setImage(with: weatherInfo.weatherIcon)
			
			self.temperature = TemperatureParametersView(temperature: weatherInfo.temperature)
			setPressureHumidityWindStack(value: weatherInfo)
			
			setConstraints()
		}
	}
	
	// MARK: - IBOutlets
	
	private let contentView = UIView()
	
	private let locality: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProDisplay.rawValue, size: 34)
		return label
	}()
	
	private var temperature = UIView()

	private let weatherDescriprion: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProText.rawValue, size: 22)
		label.snp.makeConstraints { $0.width.equalTo(100) }
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = true
		label.lineBreakMode = .byWordWrapping
		label.textAlignment = .center
		label.textColor = #colorLiteral(red: 0.1137254902, green: 0.1176470588, blue: 0.1215686275, alpha: 1)
		return label
	}()
	
	private let weatherIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.kf.indicatorType = .activity
		imageView.contentMode = .center
		return imageView
	}()
	
	private lazy var weatherDescriptionStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [weatherIcon, weatherDescriprion])
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = -5
		return stack
	}()
	
	private lazy var mainParametersStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [temperature, weatherDescriptionStack])
		stack.axis = .vertical
		stack.alignment = .leading
		stack.spacing = -10
		return stack
	}()
	
	private lazy var mainParametersAndCityNameStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [locality, mainParametersStack])
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		stack.spacing = 30
		return stack
	}()
	
	private lazy var additionalParametersStack = UIStackView()
	
	private lazy var infoStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [mainParametersAndCityNameStack, additionalParametersStack])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.spacing = 30
		return stack
	}()
	
	private let mainWeatherImage: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		
		let mask = UIImageView(image: UIImage(named: "mask"))
		mask.alpha = 1
		imageView.mask = mask
		
		return imageView
	}()
	
	private let activityView = UIActivityIndicatorView(style: .large)
	
	// MARK: - Public Methods
	
	func startActivityIndicator() {
		setActivityViewConstraints()
		activityView.isHidden = false
		activityView.startAnimating()
	}
	
	func stopActivityIndicator() {
		activityView.stopAnimating()
		activityView.isHidden = true
	}
	
	// MARK: - Private Methods
	private func setPressureHumidityWindStack(value: WeatherInfo) {
		
		let pressure = PressureHumidityWindInfoView(parameter: "Pressure", value: value.pressure)
		let humidity = PressureHumidityWindInfoView(parameter: "Humidity", value: value.humidity)
		let wind = PressureHumidityWindInfoView(parameter: "Wind", value: value.windValue)
		
		setStack(humidity: humidity, pressure: pressure, wind: wind)
	}
	
	private func setConstraints() {
		setContentView()
		setImageView()
	}
	
	private func setContentView() {
		self.addSubview(contentView)
		
		contentView.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
			make.left.equalToSuperview().offset(25)
			make.right.equalToSuperview()
			make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
		}
	}
	
	private func setActivityViewConstraints() {
		self.addSubview(activityView)
		activityView.snp.makeConstraints { $0.center.equalToSuperview() }
	}
	
	private func setImageView() {
		
		self.addSubview(mainWeatherImage)
		mainWeatherImage.snp.makeConstraints { $0.bottom.right.equalToSuperview() }
	}
	
	private func setStack(humidity: PressureHumidityWindInfoView, pressure: PressureHumidityWindInfoView, wind: PressureHumidityWindInfoView) {
		additionalParametersStack = UIStackView(arrangedSubviews: [humidity, pressure, wind])
		additionalParametersStack.axis = .vertical
		additionalParametersStack.distribution = .equalSpacing
		
		contentView.addSubview(infoStack)
		
		infoStack.snp.makeConstraints { make in
			make.top.equalTo(contentView.snp.top)
			make.left.equalToSuperview()
			make.bottom.equalTo(contentView.snp.bottom).offset(-25)
		}
	}
}
