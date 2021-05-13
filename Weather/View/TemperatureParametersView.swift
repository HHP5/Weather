//
//  MainWeatherParametersView.swift
//  Weather
//
//  Created by Екатерина Григорьева on 13.05.2021.
//

import UIKit

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
	
	// MARK: - Init
	
	init(temperature: String?) {
		self.temperature.text = temperature
		
		super.init(frame: .zero)
		
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Private Methods
	
	private func setConstraints() {
		self.addSubview(temperature)
		temperature.snp.makeConstraints { make in
			make.top.bottom.left.equalToSuperview()
		}
		
		self.addSubview(celsius)
		celsius.snp.makeConstraints { make in
			make.left.equalTo(temperature.snp.right)
			make.top.equalToSuperview().offset(10)
			make.height.width.equalTo(70)
		}
	}
}
