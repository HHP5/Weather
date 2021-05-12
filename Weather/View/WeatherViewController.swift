//
//  WeatherViewController.swift
//  Weather
//
//  Created by Екатерина Григорьева on 25.04.2021.
//

import UIKit

class WeatherViewController: UIViewController {
	
	// MARK: - Properties

	private var viewModel: WeatherViewModelType

	// MARK: - Init

	init(viewModel: WeatherViewModelType) {

		self.viewModel = viewModel
		
		super.init(nibName: nil, bundle: nil)

		viewModel.fetcingWeather()
		self.bindToViewModel()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle

	override func loadView() {
		self.view = WeatherView()

	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		setNavBar()
		
		view()?.startActivityIndicator()

	}
	
	// MARK: - Private Methods
	
	private func view() -> WeatherView? {
	   return self.view as? WeatherView
	}
	
	private func bindToViewModel() {

		viewModel.didFinishRequest = { [weak self] in
			self?.view()?.stopActivityIndicator()
		}

		viewModel.didUpdateData = { [weak self]  in
			self?.view()?.setConstraints()
			self?.updatePage()
		}

		viewModel.didReceiveError = { [weak self] error in
		
			let alert = AlertService.alert(message: error.localizedDescription)
			self?.present(alert, animated: true)
		}
	}
	
	private func updatePage() {
		view()?.weatherInfo = WeatherInfo(locality: viewModel.locality,
										  weatherDescriprion: viewModel.weatherDescription,
										  temperature: viewModel.temperature,
										  pressure: viewModel.pressure,
										  humidity: viewModel.humidity,
										  windValue: viewModel.wind,
										  mainWeatherImage: viewModel.mainWeatherImage,
										  weatherIcon: viewModel.imageWeather)
	}
	
	private func setNavBar() {
		navigationController?.navigationBar.topItem?.backButtonTitle = "Map"
		navigationController?.navigationBar.barStyle = .black
		navigationController?.navigationBar.barTintColor = .white
	}

}
