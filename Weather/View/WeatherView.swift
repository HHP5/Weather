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
			mainWeatherImage.image = weatherInfo.mainWeatherImage
			
			self.weather = TemperatureParametersView(for: weatherInfo)
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

	private var weather = UIView()

	private lazy var mainParametersAndCityNameStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [locality, weather])
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		stack.alignment = .leading
		stack.spacing = 20
		return stack
	}()
	
	private lazy var additionalParametersStack = UIStackView()
	
	private lazy var stack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [mainParametersAndCityNameStack, additionalParametersStack])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.spacing = 20
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
		
		let pressure = PressureHumidityWindInfoView(parameter: AdditionalWeatherParameters.pressure.rawValue, value: value.pressure)
		let humidity = PressureHumidityWindInfoView(parameter: AdditionalWeatherParameters.humidity.rawValue, value: value.humidity)
		let wind = PressureHumidityWindInfoView(parameter: AdditionalWeatherParameters.wind.rawValue, value: value.windValue)
		
		makeParametersStack(parameters: [humidity, wind, pressure])
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
		mainWeatherImage.snp.makeConstraints { make in
			make.bottom.equalToSuperview()
			make.right.equalToSuperview()
		}
	}
	
	private func makeParametersStack(parameters: [PressureHumidityWindInfoView]) {
		additionalParametersStack = UIStackView(arrangedSubviews: parameters)
		additionalParametersStack.axis = .vertical
		additionalParametersStack.distribution = .equalSpacing
		
		setupStack()
	}
	
	private func setupStack() {
		contentView.addSubview(stack)
		
		stack.snp.makeConstraints { make in
			make.top.equalTo(contentView.snp.top)
			make.left.equalToSuperview()
			make.bottom.equalTo(contentView.snp.bottom).offset(-25)
		}
	}
}
