//
//  GeocoderService.swift
//  Weather
//
//  Created by Екатерина Григорьева on 18.05.2021.
//

import Foundation
import MapKit

class GeocoderService {
	
	func lookUpLocationName(location: CLLocation, _ handler: @escaping (String) -> Void) {
		location.lookUpPlaceMark { placemark in
			if let locality = placemark?.locality {
				
				handler(locality)
			}
		}
	}
	
	func getCoordinate(addressString: String, completion: @escaping(SearchResult) -> Void) {
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(addressString) { placemarks, error in
			if error == nil {
				if let placemark = placemarks?.first {

					if let location = placemark.location {
						completion(.success(location))
						return
					}
				}
			} else {
				print("ffffffff")
				completion(.failure(AlertService.alert(message: "Enter the correct locality name")))
			}
		}
	}
}
