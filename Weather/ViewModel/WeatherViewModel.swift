//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Екатерина Григорьева on 28.04.2021.
//

import Foundation
import UIKit
import MapKit

class WeatherViewModel: WeatherViewModelType {
	// MARK: - Properties

	var location: CLLocation
	var didFinishRequest: (() -> Void)?
	var didUpdateData: (() -> Void)?
	var didReceiveError: ((Error) -> Void)?
	var locality: String?
	var temperature: String?
	var humidity: String?
	var wind: String?
	var pressure: String?
	var weatherDescription: String?
	var imageWeather: URL?
	var mainWeatherImage: UIImage?
	
	private let geocoderService = GeocoderService()
	private var serviceLayer = ServiceLayer()
	
	// MARK: - Init

	init(location: CLLocation) {
		self.location = location
	}
	
	// MARK: - Public Methods

	func fetchingWeather() {
		
		geocoderService.lookUpLocationName(location: location) {  [weak self] city in
			
			self?.locality = city
						
			self?.serviceLayer.request(router: Router.weather(city: city)) { [weak self] (result: Result<WeatherResponse, Error>) in
				
				DispatchQueue.main.async { self?.didFinishRequest?() }
				
				switch result {

				case .success(let result):
					
					self?.handleResult(result)

					DispatchQueue.main.async { self?.didUpdateData?() }

				case .failure(let error):

					DispatchQueue.main.async { self?.didReceiveError?(error) }
					
				}
			}
		}
	}
	// MARK: - Private Methods

	private func handleResult(_ result: WeatherResponse) {
		
		self.temperature = result.main.calculateTemperature()
		self.pressure = result.main.calculatePressure()
		self.wind = result.wind.calculateWindDirection()
		self.humidity = result.main.calculateHumidity()
		
		if let icon = result.weather.first {
			self.imageWeather = icon.url
			self.weatherDescription = icon.description
			self.mainWeatherImage = WeatherImage(icon: icon.icon).mainImage
		}
	}
}
