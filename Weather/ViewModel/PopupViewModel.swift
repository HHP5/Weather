//
//  PopupViewModel.swift
//  Weather
//
//  Created by Екатерина Григорьева on 25.04.2021.
//

import Foundation
import MapKit

class PopupViewModel: PopupViewModelType {
	var location: CLLocation

	var cityName: String
	
	var latitude: String {
		let lat = location.coordinate.latitude
		return convertDDintoDMS(location: lat, .latitude)
	}
	
	var longitude: String {
		let lon = location.coordinate.longitude
		return convertDDintoDMS(location: lon, .longitude)
	}
	
	init(location: CLLocation, cityName: String) {
		self.cityName = cityName
		self.location = location
	}
	
	private func convertDDintoDMS(location: CLLocationDegrees, _ locationDegrees: LocationDegrees) -> String {
		var symbol = ""
		
		if locationDegrees == .latitude {
			symbol = location < 0 ? "S" : "N"
		} else {
			symbol = location < 0 ? "W" : "E"
		}
		
		let newlocation = location < 0 ? -location : location
		
		let degrees = Int(newlocation)
		let minutes = Int((newlocation - Double(degrees)) * 60)
		let seconds = String(format: "%.1f", (newlocation - Double(degrees) - Double(minutes) / 60) * 3600)
		
		var result = "\(degrees)\u{00B0}"
		result += "\(minutes)'"
		result += "\(seconds)\u{0022}\(symbol)"
		return result
	}
}