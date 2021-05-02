//
//  Weather.swift
//  Weather
//
//  Created by Екатерина Григорьева on 28.04.2021.
//

import Foundation
import UIKit

struct WeatherResponse: Codable {
	let weather: [WeatherIcon]
	let main: WeatherMain
	let wind: WeatherWind
}

struct WeatherIcon: Codable {
	
	let description: String
	let icon: Icon
	
}

struct WeatherMain: Codable {
	let temp: Double
	let pressure: Double
	let humidity: Double

}

struct WeatherWind: Codable {
	
	let speed: Double
	let deg: Int
}

enum Icon: String, Codable {
	
	case clearSkyNight = "01n"
	case fewCloudsNight = "02n"
	case scatteredCloudsNight = "03n"
	case brokenCloudsNight = "04n"
	case showerRainNight = "09n"
	case rainNight = "10n"
	case thunderstormNight = "11n"
	case snowNight = "13n"
	case mistNight = "50n"
	
	case clearSkyDay = "01d"
	case fewCloudsDay = "02d"
	case scatteredCloudsDay = "03d"
	case brokenCloudsDay = "04d"
	case showerRainDay = "09d"
	case rainDay = "10d"
	case thunderstormDay = "11d"
	case snowDay = "13d"
	case mistDay = "50d"
		
}


enum WeatherImage {
	case mist
	case rain
	case showerRain
	case snow
	case thunderstorm
	case clearSky
	case scatteredClouds
	case brokenClouds
	case fewClouds

	var image: UIImage? {
		
		switch self {
		case .brokenClouds:
			return UIImage(named: "brokenclouds")
		case .fewClouds:
			return UIImage(named: "fewclouds")
		case .clearSky:
			return UIImage(named: "clearsky")
		case .mist:
			return UIImage(named: "mist")
		case .rain:
			return UIImage(named: "rain")
		case .scatteredClouds:
			return UIImage(named: "scatteredclouds")
		case .snow:
			return UIImage(named: "snow")
		case .showerRain:
			return UIImage(named: "showerrain")
		case .thunderstorm:
			return UIImage(named: "thunderstorm")
		}
	}	
}
