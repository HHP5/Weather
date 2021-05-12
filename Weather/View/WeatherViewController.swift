//
//  WeatherViewController.swift
//  Weather
//
//  Created by Екатерина Григорьева on 25.04.2021.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
	
	// MARK: - Properties

	private var viewModel: WeatherViewModelType
	private let weatherView = WeatherView()

	// MARK: - Init

	init(viewModel: WeatherViewModelType) {

		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
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
		setupWeatherView()
		setupNavigationBar()
		
		viewModel.fetcingWeather()
		bindToViewModel()
		
		weatherView.startActivityIndicator()
	}
	
	// MARK: - Private Methods
	
	private func bindToViewModel() {

		viewModel.didFinishRequest = { [weak self] in
			self?.weatherView.stopActivityIndicator()
		}

		viewModel.didUpdateData = { [weak self]  in
			self?.updatePage()
		}

		viewModel.didReceiveError = { [weak self] error in
		
			let alert = AlertService.alert(message: error.localizedDescription)
			self?.present(alert, animated: true)
		}
	}
	
	private func updatePage() {
		weatherView.weatherInfo = WeatherInfo(locality: viewModel.locality,
										  weatherDescriprion: viewModel.weatherDescription,
										  temperature: viewModel.temperature,
										  pressure: viewModel.pressure,
										  humidity: viewModel.humidity,
										  windValue: viewModel.wind,
										  mainWeatherImage: viewModel.mainWeatherImage,
										  weatherIcon: viewModel.imageWeather)
	}
	
	private func setupNavigationBar() {
		navigationController?.navigationBar.topItem?.backButtonTitle = "Map"
		navigationController?.navigationBar.barStyle = .black
		navigationController?.navigationBar.barTintColor = .white
	}
	
	private func setupWeatherView() {
		view.backgroundColor = .white

		view.addSubview(weatherView)

		weatherView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

}
