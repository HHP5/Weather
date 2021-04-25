//
//  MapViewModel.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import Foundation
import MapKit

class MapViewModel {
	func cityNameAndCoordinateInPoint(location: CLLocation, city name: String) -> PopupViewModelType {
		return PopupViewModel(location: location, cityName: name)
	}
}
