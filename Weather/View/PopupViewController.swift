//
//  PopupViewController.swift
//  Weather
//
//  Created by Екатерина Григорьева on 25.04.2021.
//

import UIKit

class PopupViewController: UIViewController {
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
	
	private let showWeatherButton: UIButton = {
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
	
	private let closeButton: UIButton = {
		let button = UIButton()
		let image = UIImage(systemName: "xmark")
		image?.withTintColor(.systemBlue)
		button.setImage(image, for: .normal)
		button.frame.size = CGSize(width: 15, height: 15)
		return button
	}()
	
	@objc private func closePopup() {
//		self.dismiss(animated: true, completion: nil)
		self.navigationController?.popViewController(animated: true)
	}
	
	@objc private func showWeather() {
		let destinationVC = WeatherViewController()
//		destinationVC.modalPresentationStyle = .fullScreen
//		destinationVC.modalTransitionStyle = .flipHorizontal
		print("ffffff")
		self.navigationController?.pushViewController(destinationVC, animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setConstraints()
		closeButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
		showWeatherButton.addTarget(self, action: #selector(showWeather), for: .touchUpInside)
	}
	
	private func setConstraints() {
		setContainer()
		setLabelStack()
		setShowWeatherButton()
		setCloseButton()
		
	}
	
	private func setContainer() {
		view.addSubview(container)
		
		container.translatesAutoresizingMaskIntoConstraints = false
		container.heightAnchor.constraint(equalToConstant: 170).isActive = true
		container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
		container.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
		container.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
	}
	
	private func setLabelStack() {
		container.addSubview(labelStack)
		
		labelStack.translatesAutoresizingMaskIntoConstraints = false
		labelStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20).isActive = true
		labelStack.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 20).isActive = true
		labelStack.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -20).isActive = true
	}
	
	private func setShowWeatherButton() {
		container.addSubview(showWeatherButton)
		
		showWeatherButton.translatesAutoresizingMaskIntoConstraints = false
		showWeatherButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15).isActive = true
		showWeatherButton.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 15).isActive = true
		showWeatherButton.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -15).isActive = true
		showWeatherButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
	
	private func setCloseButton() {
		container.addSubview(closeButton)
		closeButton.translatesAutoresizingMaskIntoConstraints = false
		closeButton.topAnchor.constraint(equalTo: labelStack.topAnchor).isActive = true
		closeButton.rightAnchor.constraint(equalTo: showWeatherButton.rightAnchor).isActive = true
	}
	
}
