//
//  CLLocation+LookUpPlacemark.swift
//  Weather
//
//  Created by Екатерина Григорьева on 12.05.2021.
//

import Foundation
import MapKit

extension CLLocation {
	
	func lookUpPlaceMark(_ handler: @escaping (CLPlacemark?) -> Void) {
		
		let geocoder = CLGeocoder()
		
		geocoder.reverseGeocodeLocation(self) { placemarks, error in
			
			guard error == nil else {
				
				handler(nil)
				return
			}
			
			if let location = placemarks?.first {
				
				handler(location)
			}
		}
	}
}
