//
//  WeatherImages.swift
//  Weather
//
//  Created by Екатерина Григорьева on 18.05.2021.
//

import UIKit

struct WeatherImage {
	var mainImage: UIImage?

	private var icon: Icon?
	
	init(icon: Icon?) {
		self.icon = icon
		mainWeatherImage()
	}
	
	private mutating func mainWeatherImage() {
		
		var result: UIImage?
		
		switch icon {
		case .brokenCloudsDay, .brokenCloudsNight:
			result = WeatherImage.brokenClouds.image
		case .clearSkyNight, .clearSkyDay:
			result = WeatherImage.clearSky.image
		case .fewCloudsNight, .fewCloudsDay:
			result = WeatherImage.fewClouds.image
		case .mistNight, .mistDay:
			result = WeatherImage.mist.image
		case .rainNight, .rainDay:
			result = WeatherImage.rain.image
		case .scatteredCloudsNight, .scatteredCloudsDay:
			result = WeatherImage.scatteredClouds.image
		case .showerRainNight, .showerRainDay:
			result = WeatherImage.showerRain.image
		case .snowDay, .snowNight:
			result = WeatherImage.snow.image
		case .thunderstormNight, .thunderstormDay:
			result = WeatherImage.thunderstorm.image
		case .none:
			break
		}
		self.mainImage = result
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
}
