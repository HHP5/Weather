//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Екатерина Григорьева on 28.04.2021.
//

import Foundation
import UIKit

class WeatherViewModel: WeatherViewModelType {
	private var serviceLayer = ServiceLayer()
	
	var didFinishRequest: (() -> Void)?
	
	var didUpdateData: (() -> Void)?
	
	var didReceiveError: ((Error) -> Void)?

	init(city: String) {
		self.city = city
	}
	
	var city: String
	
	var temperature: String?
	
	var humidity: String?
	
	var wind: String?
	
	var pressure: String?
	
	var weatherDescription: String?
	
	var imageWeather: URL?
	
	var mainWeatherImage: UIImage?
	
	func fetcingWeather() {
				
		serviceLayer.request(router: Router.weather(city: city)) { [weak self] (result: Result<WeatherResponse, Error>) in
			
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
	
	private func handleResult(_ result: WeatherResponse) {
		
		self.handleWeatherIcon(result.weather.first)
		
		self.handlePressure(result.main.pressure)
		
		self.handleWindParameters(result.wind)
		
		self.mainWeatherImage(icon: result.weather.first?.icon)
		
		self.weatherDescription = result.weather.first?.description
		
		self.handleTemperature(result.main.temp)
		
		self.handleHumidity(result.main.humidity)
	}
	
	private func handleHumidity(_ humidity: Double) {
		self.humidity = String(Int(humidity)) + " %"
	}
	
	private func handleWeatherIcon(_ icon: WeatherIcon?) {
		guard  let picture = icon,
			   let url = URL(string: "http://openweathermap.org/img/wn/\(picture.icon.rawValue)@2x.png") else { return }
		
		self.imageWeather = url
	}
	
	private func handleTemperature(_ temperature: Double) {
		self.temperature = String(Int(temperature - 273.15))
	}
	
	private func handlePressure(_ pressure: Double) {
		self.pressure = String(format: "%.2f", pressure * 0.750062) + " mm Hg"
	}
	
	private func mainWeatherImage(icon: Icon?) {
		
		guard let icon = icon else { return  }
		
		switch icon {
		case .brokenCloudsDay, .brokenCloudsNight:
			self.mainWeatherImage = WeatherImage.brokenClouds.image
		case .clearSkyNight, .clearSkyDay:
			self.mainWeatherImage = WeatherImage.clearSky.image
		case .fewCloudsNight, .fewCloudsDay:
			self.mainWeatherImage = WeatherImage.fewClouds.image
		case .mistNight, .mistDay:
			self.mainWeatherImage = WeatherImage.mist.image
		case .rainNight, .rainDay:
			self.mainWeatherImage = WeatherImage.rain.image
		case .scatteredCloudsNight, .scatteredCloudsDay:
			self.mainWeatherImage = WeatherImage.scatteredClouds.image
		case .showerRainNight, .showerRainDay:
			self.mainWeatherImage = WeatherImage.showerRain.image
		case .snowDay, .snowNight:
			self.mainWeatherImage = WeatherImage.snow.image
		case .thunderstormNight, .thunderstormDay:
			self.mainWeatherImage = WeatherImage.thunderstorm.image
		}
	}

	private func handleWindParameters(_ wind: WeatherWind) {
		var result = ""
		
		let deg = wind.deg
		
		switch deg {
		
		case 0...22:
			result += "N"
		case 23...67:
			result += "NE"
		case 68...112:
			result += "E"
		case 113...157:
			result += "SE"
		case 158...202:
			result += "S"
		case 203...247:
			result += "SW"
		case 248...292:
			result += "W"
		case 293...337:
			result += "NW"
		case 334...360:
			result += "N"
		default:
			return
		}
		
		let speed = Int(wind.speed)
		
		result += " \(speed) m/s"
		
		self.wind = result
	}

}
