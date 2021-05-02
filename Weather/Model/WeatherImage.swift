//
//  WeatherImage.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import Foundation
import UIKit

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
