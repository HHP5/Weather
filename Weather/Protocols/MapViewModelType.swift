//
//  MapViewModelType.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import UIKit
import MapKit

protocol MapViewModelType {
	var currentLocation: CLLocation {get set}
	
	var onDidUpdateCurrentLocation: ((CLLocationCoordinate2D) -> Void)? {get set}
	
	var notFoundAnyLocality: ((UIAlertController) -> Void)? {get set}
	
	var onDidUpdatePopupViewModel: ((PopupViewModelType) -> Void)? {get set}
	
	func weatherPoint() -> WeatherViewModel
	
	func coordinateInPoint()

	func search(for searchText: String)

}
