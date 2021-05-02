//
//  PopupView.swift
//  Weather
//
//  Created by Екатерина Григорьева on 27.04.2021.
//

import UIKit
import SnapKit

class PopupView: UIView {
	var viewModel: PopupViewModelType

	required init(viewModel: PopupViewModelType) {
		print("POPUP")
		self.viewModel = viewModel
		
		super.init(frame: UIScreen.main.bounds)
						
		viewModel.getCityNameAndCoordinate()
		self.bindToViewModel()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func bindToViewModel() {
		print("hae")
		viewModel.didFindLocality = { [weak self] condition in
			print("dvefg")

			print(condition)
			
			switch condition {
			case true:
				print("yes")
				self?.updatePage()
				self?.setConstraints()
			default:
				print("fevvbvbgfgerfrv")
//				self?.removeFromSuperview()
			}
			
		}
		print("gfmgjjg")
		self.removeFromSuperview()

	}
	
	private func updatePage() {
		localityLabel.text = viewModel.locality
		coordinateLabel.text = viewModel.coordinate
	}
	 
	private let localityLabel: UILabel = {
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
		let stack = UIStackView(arrangedSubviews: [localityLabel, coordinateLabel])
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
		return button
	}()
	
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
