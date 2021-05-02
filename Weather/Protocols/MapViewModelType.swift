//
//  MapViewModelType.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import Foundation
import MapKit

protocol MapViewModelType {	
	func coordinateInPoint(location: CLLocation) -> PopupViewModelType
	
	func weatherPoint(location: CLLocation) -> WeatherViewModel
	
}
