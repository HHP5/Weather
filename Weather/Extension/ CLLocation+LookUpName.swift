//
//  CLLocation.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import Foundation
import MapKit

extension CLLocation {
	
	func lookUpLocationName(_ handler: @escaping (String) -> Void) {
		
		lookUpPlaceMark { placemark in
			if let locality = placemark?.locality {
				
				handler(locality)
			}
		}
	}
}
