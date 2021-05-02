//
//  PopupView.swift
//  Weather
//
//  Created by Екатерина Григорьева on 27.04.2021.
//

import UIKit
import SnapKit

class PopupView: UIView {
	var viewModel: PopupViewModelType? {
		willSet(viewModel) {
			guard let viewModel = viewModel else { return }
			
			nameLabel.text = viewModel.cityName
			coordinateLabel.text = "\(viewModel.latitude)   \(viewModel.longitude)"
		}
	}
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		return label
	}()
	
	private let coordinateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17, weight: .light)
		label.textColor = .lightGray
		return label
	}()
	
	private let container: UIView = {
		let container = UIView()
		container.backgroundColor = .white
		container.layer.cornerRadius = 20
		container.clipsToBounds = true
		return container
	}()
	
	private lazy var labelStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [nameLabel, coordinateLabel])
		stack.axis = .vertical
		stack.spacing = 10
		return stack
	}()
	
	let showWeatherButton: UIButton = {
		let button = UIButton()
		button.setTitle("Show Weather", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .light)
		button.setTitleColor(.systemBlue, for: .normal)
		button.layer.borderColor = UIColor.systemBlue.cgColor
		button.layer.cornerRadius = 20
		button.clipsToBounds = true
		button.layer.borderWidth = 0.5
		return button
	}()
	
	let closeButton: UIButton = {
		let button = UIButton()
		button.frame.size = CGSize(width: 40, height: 40)
		let image = UIImage(systemName: "xmark")
		image?.withTintColor(.systemBlue)

		button.imageView?.contentMode = .scaleToFill
		button.setImage(image, for: .normal)
		button.addTarget(self, action: #selector(closePopup), for: .allEvents)
		return button
	}()
	
	@objc private func closePopup() {
		self.removeFromSuperview()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setConstraints() {
		setContainer()
		setLabelStack()
		setShowWeatherButton()
		setCloseButton()
	}
	
	func setContainer() {
		self.addSubview(container)
		
		container.snp.makeConstraints { make in
			make.height.equalTo(170)
			make.bottom.equalToSuperview().offset(-20)
			make.left.equalToSuperview().offset(30)
			make.right.equalToSuperview().offset(-30)
		}
	}
	
	private func setLabelStack() {
		container.addSubview(labelStack)
		
		labelStack.snp.makeConstraints { make in
			make.top.equalTo(container.snp.top).offset(20)
			make.left.equalTo(container.snp.left).offset(20)
			make.right.equalTo(container.snp.right).offset(-20)
		}
	}
	
	private func setShowWeatherButton() {
		container.addSubview(showWeatherButton)
		
		showWeatherButton.snp.makeConstraints { make in
			make.bottom.equalTo(container.snp.bottom).offset(-15)
			make.left.equalTo(container.snp.left).offset(15)
			make.right.equalTo(container.snp.right).offset(-15)
			make.height.equalTo(40)
		}
	}
	
	private func setCloseButton() {
		container.addSubview(closeButton)
		
		closeButton.snp.makeConstraints { make in
			make.right.equalTo(showWeatherButton.snp.right)
			make.top.equalTo(labelStack.snp.top)
		}
	}
	
}
