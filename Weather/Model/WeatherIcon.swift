//
//  WeatherIcon.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import UIKit

struct WeatherIcon: Codable {
	
	let description: String
	let icon: Icon
	
	var url: URL? {
		return handleWeatherIcon()
	}
	
	private func handleWeatherIcon() -> URL? {
		guard let url = URL(string: "http://openweathermap.org/img/wn/\(icon.rawValue)@2x.png") else { return nil }
		return url
	}

}
