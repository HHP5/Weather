//
//  WeatherViewController.swift
//  Weather
//
//  Created by Екатерина Григорьева on 25.04.2021.
//

import UIKit
import Kingfisher

class WeatherViewController: UIViewController {
	private var viewModel: WeatherViewModelType

	init(viewModel: WeatherViewModelType) {
		
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		viewModel.fetcingWeather()
		self.bindToViewModel()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = WeatherView()

	}
	
	func view() -> WeatherView? {
	   return self.view as? WeatherView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		setNavBar()
		
		view()?.startActivityIndicator()

	}

	private func bindToViewModel() {

		viewModel.didFinishRequest = { [weak self] in
			self?.view()?.stopActivityIndicator()
			self?.view()?.setConstraints()
		}

		viewModel.didUpdateData = { [weak self]  in
			self?.updatePage()
		}

//		viewModel.didReceiveError = { [weak self] error in
//
//			let alert = AlertService.alert(message: error.localizedDescription)
//			self?.present(alert, animated: true)
//
//			return
//		}
	}
	
	private func updatePage() {
		view()?.cityName.text = viewModel.city
		view()?.weatherDescriprion.text = viewModel.weatherDescription
		view()?.temperature.text = viewModel.temperature
		view()?.pressureValue.text = viewModel.pressure
		view()?.humidityValue.text = viewModel.humidity
		view()?.windValue.text = viewModel.wind
				
		view()?.mainWeatherImage.image = viewModel.mainWeatherImage
//		view()?.mainWeatherImage.image = UIImage(named: "mask")

//		let maskView = UIImageView()
//		maskView.image = viewModel.mainWeatherImage
//		maskView.frame = (view()?.mainWeatherImage.bounds)!
//		view()?.mainWeatherImage.layer.masksToBounds = true
//		view()?.mainWeatherImage.clipsToBounds = true
//
//		view()?.mainWeatherImage.mask = maskView
		
		if let image = viewModel.imageWeather {
			view()?.weatherIcon.kf.setImage(with: image)
		}
	}
	
	private func setNavBar() {
		navigationController?.navigationBar.topItem?.backButtonTitle = "Map"
		navigationController?.navigationBar.barStyle = .black
		navigationController?.navigationBar.barTintColor = .white
	}

}
