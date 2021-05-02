//
//  MapViewModelType.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import Foundation
import MapKit

protocol MapViewModelType {
	var city: String? {get}
	
	func coordinateInPoint(location: CLLocation, city: String) -> PopupViewModelType?
	
	func weatherPoint(location: CLLocation, city: String) -> WeatherViewModel?
	
	func lookUpName(location: CLLocation) 
}
