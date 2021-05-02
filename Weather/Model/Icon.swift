//
//  Icon.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import Foundation

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
