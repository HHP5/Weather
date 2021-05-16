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

	var onDidUpdatePopupViewModel: ((PopupViewModelType) -> Void)?
	
	private var locationManager: CLLocationManager = {
		let locationManager = CLLocationManager()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 10
		return locationManager
	}()
	
	func coordinateInPoint() {
		currentLocation.lookUpLocationName { [weak self] location in
			guard let self = self else {return}
			self.onDidUpdatePopupViewModel?(PopupViewModel(location: self.currentLocation))
		}
	}
	
	func weatherPoint() -> WeatherViewModel {
		return WeatherViewModel(location: currentLocation)
	}
	
	func searchBarSearchButtonClicked(for searchText: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
		self.locationManager.getCoordinate(addressString: searchText) { location in
			completion(location.coordinate)
		}
	}
	
	func checkLocationAuthorization() -> UIAlertController? {
		var result: UIAlertController? 
		switch locationManager.authorizationStatus {
		case .authorizedWhenInUse:
			break
		case .denied:
			let alert = AlertService.alert(title: "Вы запретили использование местоположения",
										   message: "Измените это в настройках",
										   url: URL(string: UIApplication.openSettingsURLString))
			result = alert
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
		case .restricted:
			break
		case .authorizedAlways:
			break
		@unknown default:
			break
		}
		return result
	}
}
