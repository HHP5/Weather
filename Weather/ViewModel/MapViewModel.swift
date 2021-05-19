//
//  MapViewModel.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import Foundation
import MapKit

class MapViewModel: MapViewModelType {
	var currentLocation = CLLocation()

	var onDidUpdateCurrentLocation: ((CLLocationCoordinate2D) -> Void)?
	
	var notFoundAnyLocality: ((UIAlertController) -> Void)?
	
	var onDidUpdatePopupViewModel: ((PopupViewModelType) -> Void)?
	
	private let geocoderService = GeocoderService()
	
	private var locationManager: CLLocationManager = {
		let locationManager = CLLocationManager()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 10
		return locationManager
	}()
	
	func coordinateInPoint() {
		geocoderService.lookUpLocationName(location: currentLocation) { [weak self] locality in
			guard let self = self else {return}
			self.onDidUpdatePopupViewModel?(PopupViewModel(location: self.currentLocation, locality: locality))
		}
	}
	
	func weatherPoint() -> WeatherViewModel {
		return WeatherViewModel(location: currentLocation)
	}
	
	func search(for searchText: String) {
		geocoderService.getCoordinate(addressString: searchText) { [weak self] (result: SearchResult) in
			
			switch result {
			case .success(let location):
				DispatchQueue.main.async { self?.onDidUpdateCurrentLocation?(location.coordinate) }
			case .failure(let alert):
				DispatchQueue.main.async { self?.notFoundAnyLocality?(alert) }
			}
		}
	}
	
}
