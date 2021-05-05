//
//  LocationManager.swift
//  Weather
//
//  Created by Екатерина Григорьева on 04.05.2021.
//

import Foundation
import MapKit

extension CLLocationManager {
	
	func getCoordinate(addressString: String, completionHandler: @escaping(CLLocation) -> Void) {
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(addressString) { placemarks, error in
			if error == nil {
				if let placemark = placemarks?[0] {
					
					if let location = placemark.location {
						completionHandler(location)
						return
					}
				}
			}
		}
	}
}
