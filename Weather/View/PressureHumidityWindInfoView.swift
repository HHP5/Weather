//
//  PressureHumidityWindInfoView.swift
//  Weather
//
//  Created by Екатерина Григорьева on 13.05.2021.
//

import UIKit
import SnapKit

class PressureHumidityWindInfoView: UIView {
	// MARK: - IBOutlets

	private let name: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProText.rawValue, size: 20)
		label.textColor = .black
		return label
	}()
	
	private let value: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: FontStyle.sfProTextSemibold.rawValue, size: 20)
		label.textColor = .black
		return label
	}()
	
	private lazy var stack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [name, value])
		stack.axis = .vertical
		stack.spacing = 5
		return stack
	}()
	
	// MARK: - Init
	
	init(parameter: AdditionalWeatherParameters.RawValue, value: String?) {
		self.name.text = parameter
		self.value.text = value
		
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
	}
}
