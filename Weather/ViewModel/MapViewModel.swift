//
//  MapViewModel.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import Foundation
import MapKit

class MapViewModel: MapViewModelType {
	private let locationManager = CLLocationManager()
	
	func coordinateInPoint(location: CLLocation, completion: @escaping (PopupViewModelType) -> Void) {
		location.lookUpLocationName { _ in
			completion(PopupViewModel(location: location))
		}
	}
	
	func weatherPoint(location: CLLocation) -> WeatherViewModel {
		return WeatherViewModel(location: location)
	}
	
	func searchBarSearchButtonClicked(for searchText: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
		self.locationManager.getCoordinate(addressString: searchText) { location in
			completion(location.coordinate)
		}
	}
}
