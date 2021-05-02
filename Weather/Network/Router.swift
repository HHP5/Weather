//
//  Router.swift
//  Weather
//
//  Created by Екатерина Григорьева on 28.04.2021.
//

import Foundation

enum Router {
	
	case weather(city: String)
	
	var scheme: String {
		switch self {
		case .weather:
			return "http"
		}
	}
	
	var host: String {
		switch self {
		case .weather:
			return "api.openweathermap.org"
		}
	}
	
	var path: String {
		switch self {
		case .weather:
			//			return "/data/2.5/weather?q=\(city)"
			return "/data/2.5/weather"
			
		}
	}
	
	var method: String {
		switch self {
		case .weather:
			return "GET"
		}
	}
	
	var parameters: [URLQueryItem] {
		
		switch self {
		
		case .weather(let city):
			return [ URLQueryItem(name: "q", value: city),
					 URLQueryItem(name: "appid", value: APIKey.key)]
		}
	}
	
}
