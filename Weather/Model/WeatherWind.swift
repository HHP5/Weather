//
//  WeatherWind.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import Foundation

struct WeatherWind: Codable {
	
	let speed: Double
	let deg: Int

	func calculateWindDirection() -> String? {
		var result = ""
		
		let deg = self.deg
		
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
			return nil
		}
		
		let speed = Int(self.speed)
		
		result += " \(speed) m/s"
		
		return result
	}
}
