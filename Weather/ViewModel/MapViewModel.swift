//
//  MapViewModel.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import Foundation
import MapKit

class MapViewModel: MapViewModelType {
	
	var city: String?
	
	func coordinateInPoint(location: CLLocation, city: String) -> PopupViewModelType? {
//		lookUpName(location: location)
//		guard let city = city else { return nil }
		return PopupViewModel(location: location, cityName: city)
	}
	
	func weatherPoint(location: CLLocation, city: String) -> WeatherViewModel? {
//		lookUpName(location: location)
//		guard let city = city else { return nil }
		return WeatherViewModel(city: city)
	}
	
	func lookUpName(location: CLLocation) {
		location.lookUpLocationName { name in
			self.city = name
		}
	}
}
