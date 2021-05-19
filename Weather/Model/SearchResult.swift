//
//  SearchResult.swift
//  Weather
//
//  Created by Екатерина Григорьева on 19.05.2021.
//

import UIKit
import MapKit

enum SearchResult {
	case success(CLLocation)
	case failure(UIAlertController)
}
