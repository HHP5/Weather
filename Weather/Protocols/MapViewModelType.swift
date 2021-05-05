//
//  MapViewModelType.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import Foundation
import MapKit

protocol MapViewModelType {	
	func coordinateInPoint(location: CLLocation, completion: @escaping (PopupViewModelType) -> Void)
	
	func weatherPoint(location: CLLocation) -> WeatherViewModel
	
	func searchBarSearchButtonClicked(for searchText: String, completion: @escaping (CLLocationCoordinate2D) -> Void)
}
