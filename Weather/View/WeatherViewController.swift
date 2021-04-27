//
//  WeatherViewController.swift
//  Weather
//
//  Created by Екатерина Григорьева on 25.04.2021.
//

import UIKit

class WeatherViewController: UIViewController {
	private let cityName: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
		label.text = "Milan"
		return label
	}()
	
	private let temperature: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 110, weight: .bold)
		label.text = "23"
		label.textColor = #colorLiteral(red: 0.1262762547, green: 0.1255328953, blue: 0.1268522739, alpha: 1)
		return label
	}()
	
	private let celsiusLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 40, weight: .regular)
		label.text = "\u{00B0}C"
		label.textColor = .darkGray
		return label
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .white
		setNavBar()
		setConstraints()
		drawArc()
    }
	
	private func drawArc() {
		
		let path = UIBezierPath(arcCenter: CGPoint(x: view.frame.width * 1.5, y: view.frame.height * 0.8),
								radius: view.frame.width * 1.1,
								startAngle: 60,
								endAngle: .pi,
								clockwise: false)
		
		let shapeLayer = CAShapeLayer()
		shapeLayer.path = path.cgPath
		shapeLayer.fillColor = UIColor.orange.cgColor
		
		view.layer.addSublayer(shapeLayer)
	}
	
	private func setNavBar() {
		navigationController?.navigationBar.topItem?.backButtonTitle = "Map"
		navigationController?.navigationBar.barStyle = .black
		navigationController?.navigationBar.barTintColor = .white
	}
	
	private func setConstraints() {
			
//		setColor()
		
		setCityNameLabel()
		setTemperatureLabel()
		
	}
	func setColor() {
		cityName.backgroundColor = .systemGray3
		temperature.backgroundColor = .lightGray

	}
	
	private func setCityNameLabel() {

		view.addSubview(cityName)
		
		cityName.translatesAutoresizingMaskIntoConstraints = false
		cityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
		cityName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
		cityName.invalidateIntrinsicContentSize()
	}
	
	private func setTemperatureLabel() {

		view.addSubview(temperature)
		
		temperature.translatesAutoresizingMaskIntoConstraints = false
		temperature.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 50).isActive = true
		temperature.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
		temperature.invalidateIntrinsicContentSize()
		
		setCelsiusLabel()
	}
	
	private func setCelsiusLabel() {
		view.addSubview(celsiusLabel)
		
//		celsiusLabel.backgroundColor = .yellow
		
		celsiusLabel.translatesAutoresizingMaskIntoConstraints = false
		celsiusLabel.topAnchor.constraint(equalTo: temperature.topAnchor, constant: 22).isActive = true
		celsiusLabel.leftAnchor.constraint(equalTo: temperature.rightAnchor).isActive = true
		celsiusLabel.invalidateIntrinsicContentSize()
	}
	
}
