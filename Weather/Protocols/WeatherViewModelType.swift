//
//  WeatherViewModelType.swift
//  Weather
//
//  Created by Екатерина Григорьева on 28.04.2021.
//

import Foundation
import UIKit

protocol WeatherViewModelType {
	var city: String? {get}
	
	var temperature: String? {get}
	
	var humidity: String? {get}
	
	var wind: String? {get}
	
	var pressure: String? {get}
	
	var weatherDescription: String? {get}
	
	var mainWeatherImage: UIImage? {get}
	
	var imageWeather: URL? {get}
	
	func fetcingWeather()
	
	var didFinishRequest: (() -> Void)? {get set}
	
	var didUpdateData: (() -> Void)? {get set}
	
	var didReceiveError: ((Error) -> Void)? {get set}
}
