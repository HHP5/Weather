//
//  MapViewModelType.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import Foundation
import MapKit

protocol MapViewModelType {
//	var locationManager: CLLocationManager {get set}
	var currentLocation: CLLocation {get set}
	
	func coordinateInPoint()
	
	func weatherPoint() -> WeatherViewModel
	
	func searchBarSearchButtonClicked(for searchText: String, completion: @escaping (CLLocationCoordinate2D) -> Void)
	
	var onDidUpdatePopupViewModel: ((PopupViewModelType) -> Void)? {get set}
	
	func checkLocationAuthorization() -> UIAlertController?
}
