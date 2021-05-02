//
//  WeatherView.swift
//  Weather
//
//  Created by Екатерина Григорьева on 28.04.2021.
//

import UIKit
import SnapKit

class WeatherView: UIView {
	
	let contentView = UIView()
	
	let cityName: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProDisplay.rawValue, size: 34)
		return label
	}()
	
	let temperature: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProTextSemibold.rawValue, size: 120)
		label.textColor = #colorLiteral(red: 0.1262762547, green: 0.1255328953, blue: 0.1268522739, alpha: 1)
		return label
	}()
	
	let celsius: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(named: "celsius")
		imageView.sizeToFit()
		return imageView
	}()
	
	private lazy var tempValueStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [temperature, celsius])
		stack.axis = .horizontal
		stack.alignment = .top
		return stack
	}()
	
	let weatherDescriprion: UILabel = {
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
	
	let weatherIcon: UIImageView = {
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
		let stack = UIStackView(arrangedSubviews: [tempValueStack, weatherDescriptionStack])
		stack.axis = .vertical
		stack.alignment = .leading
		stack.spacing = -10
		return stack
	}()
	
	private lazy var mainParametersAndCityNameStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [cityName, mainParametersStack])
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		stack.spacing = 30
		return stack
	}()
	
	let humidity: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProText.rawValue, size: 20)
		label.text = "HUMIDITY"
		label.textColor = .black
		return label
	}()
	
	let humidityValue: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProTextSemibold.rawValue, size: 20)
		label.textColor = .black
		return label
	}()
	
	private lazy var humidityStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [humidity, humidityValue])
		stack.axis = .vertical
		stack.spacing = 5
		return stack
	}()
	
	let wind: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProText.rawValue, size: 20)
		label.text = "WIND"
		label.textColor = .black
		return label
	}()
	
	let windValue: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProTextSemibold.rawValue, size: 20)
		label.textColor = .black
		return label
	}()
	
	private lazy var windStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [wind, windValue])
		stack.axis = .vertical
		stack.spacing = 5
		return stack
	}()
	
	let pressure: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProText.rawValue, size: 20)
		label.text = "PRESSURE"
		label.textColor = .black
		return label
	}()
	
	let pressureValue: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProTextSemibold.rawValue, size: 20)
		label.textColor = .black
		return label
	}()
	
	private lazy var pressureStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [pressure, pressureValue])
		stack.axis = .vertical
		stack.spacing = 5
		return stack
	}()
	
	private lazy var additionalParametersStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [humidityStack, windStack, pressureStack])
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		return stack
	}()

	private lazy var infoStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [mainParametersAndCityNameStack, additionalParametersStack])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.spacing = 30
		return stack
	}()
	
	let mainWeatherImage: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill

//		imageView.layer.masksToBounds = true
//		imageView.clipsToBounds = true

//		let maskView = UIImageView()
//		maskView.image = UIImage(named: "mask")
//		maskView.frame = imageView.bounds
//		imageView.mask = maskView
//
//		imageView.addSubview(maskView)
		return imageView
//		return maskView
	}()
	
	private lazy var stack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [infoStack, mainWeatherImage])
		stack.axis = .horizontal
		return stack
	}()

	private let activityView = UIActivityIndicatorView(style: .large)
	
	func setConstraints() {
	
		setContentView()
		setImageView()
		setTempStack()
		
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
	
	func startActivityIndicator() {
		setActivityViewConstraints()
		activityView.isHidden = false
		activityView.startAnimating()
	}
	
	func stopActivityIndicator() {
		activityView.stopAnimating()
		activityView.isHidden = true
	}
	
	private func setImageView() {
		
		self.addSubview(mainWeatherImage)
		
//		mainWeatherImage.snp.makeConstraints { make in
//			make.bottom.right.equalToSuperview()
//			make.height.equalTo(self.frame.height).multipliedBy(0.2)
//		}
		mainWeatherImage.snp.makeConstraints { $0.bottom.right.equalToSuperview() }
		
	}

	private func setTempStack() {
		contentView.addSubview(infoStack)
		
		infoStack.snp.makeConstraints { make in
			make.top.equalTo(contentView.snp.top)
			make.left.equalToSuperview()
			make.bottom.equalTo(contentView.snp.bottom).offset(-25)
		}
	}
}