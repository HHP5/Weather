//
//  WeatherMain.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import Foundation

struct WeatherMain: Codable {
	
	let temp: Double
	let pressure: Double
	let humidity: Double
	
	func calculatePressure() -> String {
		return String(format: "%.2f", pressure * 0.750062) + " mm Hg"
	}
	
	func calculateTemperature() -> String {
		return String(Int(temp - 273.15))
	}
	
	func calculateHumidity() -> String {
		return String(Int(humidity)) + " %"
	}

}
