//
//  MapViewModel.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import Foundation
import MapKit

class MapViewModel: MapViewModelType {
		
	func coordinateInPoint(location: CLLocation) -> PopupViewModelType {
		return PopupViewModel(location: location)
	}
	
	func weatherPoint(location: CLLocation) -> WeatherViewModel {
		return WeatherViewModel(location: location)
	}
	
}
