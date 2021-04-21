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
		map.centerCoordinate = CLLocationCoordinate2D(latitude: StartCoordinate.latitude, longitude: StartCoordinate.longitude)
		return map
	}()
	private let locationManager = CLLocationManager()
	let searchController = UISearchController(searchResultsController: nil)

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setNavBar()
		setMap()
		locationManager.delegate = self
		lookUpCurrentLocation()
		searchController.delegate = self
		//		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
		//
		//		locationManager.requestWhenInUseAuthorization()
		//		locationManager.requestLocation()
	}
	
	private func setNavBar() {
		navigationItem.title = "Global Weather"
		navigationItem.searchController = searchController
		navigationController?.navigationBar.backgroundColor = .white
	}
	
	private func setMap() {
		view.addSubview(map)
		map.translatesAutoresizingMaskIntoConstraints = false
		map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
	}
	
	func lookUpCurrentLocation() {
		// Use the last reported location.
//		if let lastLocation = self.locationManager.location {
		let lastLocation = CLLocation(latitude: 38.7703, longitude: -104.852)
			let geocoder = CLGeocoder()
			
			// Look up the location and pass it to the completion handler
			geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
				if error == nil {
					let firstLocation = placemarks?[0]
//					completionHandler(firstLocation)
					print(firstLocation)
				}
				else {
					// An error occurred during geocoding.
//					completionHandler(nil)
				}
			})
		}
//		else {
//			// No location was available.
//			completionHandler(nil)
//		}
	
//	func getLocationAddress(location:CLLocation) {
//		let geocoder = CLGeocoder()
//
//		print("-> Finding user address...")
//
//		geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error)->Void in
//			var placemark:CLPlacemark!
//
//			if error == nil && placemarks!.count > 0 {
//				placemark = placemarks![0] as CLPlacemark
//
//				var addressString : String = ""
//				if placemark.isoCountryCode == "TW" /*Address Format in Chinese*/ {
//					if placemark.country != nil {
//						addressString = placemark.country!
//					}
//					if placemark.subAdministrativeArea != nil {
//						addressString = addressString + placemark.subAdministrativeArea! + ", "
//					}
//					if placemark.postalCode != nil {
//						addressString = addressString + placemark.postalCode! + " "
//					}
//					if placemark.locality != nil {
//						addressString = addressString + placemark.locality!
//					}
//					if placemark.thoroughfare != nil {
//						addressString = addressString + placemark.thoroughfare!
//					}
//					if placemark.subThoroughfare != nil {
//						addressString = addressString + placemark.subThoroughfare!
//					}
//				} else {
//					if placemark.subThoroughfare != nil {
//						addressString = placemark.subThoroughfare! + " "
//					}
//					if placemark.thoroughfare != nil {
//						addressString = addressString + placemark.thoroughfare! + ", "
//					}
//					if placemark.postalCode != nil {
//						addressString = addressString + placemark.postalCode! + " "
//					}
//					if placemark.locality != nil {
//						addressString = addressString + placemark.locality! + ", "
//					}
//					if placemark.administrativeArea != nil {
//						addressString = addressString + placemark.administrativeArea! + " "
//					}
//					if placemark.country != nil {
//						addressString = addressString + placemark.country!
//					}
//				}
//
//				print(addressString)
//			}
//		})
//	}
	
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

extension MapViewController: UISearchControllerDelegate {
	
}
