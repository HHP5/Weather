//
//  MainWeatherParametersView.swift
//  Weather
//
//  Created by Екатерина Григорьева on 13.05.2021.
//

import UIKit
import Kingfisher
import SnapKit

class TemperatureParametersView: UIView {
	// MARK: - IBOutlets

	private let temperature: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProTextSemibold.rawValue, size: 120)
		label.textColor = #colorLiteral(red: 0.1262762547, green: 0.1255328953, blue: 0.1268522739, alpha: 1)
		return label
	}()
	
	private let celsius: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "celsius")
		imageView.alpha = 1
		return imageView
	}()
	
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
	
	private lazy var weatherStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [weatherIcon, weatherDescriprion])
		stack.axis = .vertical
		stack.alignment = .center
		return stack
	}()
	
	private lazy var stack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [temperature, weatherStack])
		stack.axis = .vertical
		stack.alignment = .center
		return stack
	}()
	// MARK: - Init
	
	init(for weatherInfo: WeatherInfo) {
		self.temperature.text = weatherInfo.temperature
		self.weatherDescriprion.text = weatherInfo.weatherDescriprion
		self.weatherIcon.kf.setImage(with: weatherInfo.weatherIcon)
		
		super.init(frame: .zero)
		
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private Methods
	
	private func setConstraints() {

		self.addSubview(stack)
		
		stack.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		self.addSubview(celsius)
		celsius.snp.makeConstraints { make in
			make.left.equalTo(temperature.snp.right)
			make.top.equalToSuperview().offset(10)
			make.height.width.equalTo(70)
		}
		
	}
}
