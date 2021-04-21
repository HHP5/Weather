//
//  ViewController.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
	private var viewModel = MapViewModel()
	
	private let map: MKMapView = {
		let map = MKMapView()
		map.isScrollEnabled = true
		map.isZoomEnabled = true
		return map
	}()
	var locationManager = CLLocationManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setMap()
		map.centerCoordinate = CLLocationCoordinate2D(latitude: viewModel.startLatitude, longitude: viewModel.startLongitude)
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
	
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
	}
	
	private func setMap() {
		view.addSubview(map)
		map.translatesAutoresizingMaskIntoConstraints = false
		map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	}
	
}

extension MapViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//		if let location = locations.last{
//			locationManager.stopUpdatingLocation()
//			let lat = location.coordinate.latitude
//			let lon = location.coordinate.longitude
//			weatherManager.fetchWeather(latitude: lat, longitude: lon)
//		}
		
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}
}
