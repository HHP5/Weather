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
