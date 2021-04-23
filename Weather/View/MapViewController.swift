//
//  ViewController.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
	private var viewModel = MapViewModel()
	private let mapView: MKMapView = {
		let map = MKMapView()
		map.isScrollEnabled = true
		map.isZoomEnabled = true
		map.isRotateEnabled = false
		map.showsUserLocation = true
		map.isPitchEnabled = true
		map.centerCoordinate = CLLocationCoordinate2D(latitude: StartCoordinate.latitude, longitude: StartCoordinate.longitude)
		return map
	}()
	
	private let locationManager: CLLocationManager = {
		let locationManager = CLLocationManager()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		//		locationManager.distanceFilter = 10
		return locationManager
	}()
	
	private let searchController: UISearchController = {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search for places"
		return searchController
	}()
	var point: [MKPointAnnotation] = []
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		searchController.delegate = self
		locationManager.delegate = self
		mapView.delegate = self
		
		setNavBar()
		setMapView()
		setGestureRecognizer()
		
		checkLocationAuthorization(status: locationManager.authorizationStatus)
		locationManager.requestWhenInUseAuthorization()
		
	}
	
	private func setGestureRecognizer() {
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		gestureRecognizer.delegate = self
		mapView.addGestureRecognizer(gestureRecognizer)
	}
	
	@objc private func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
		
		let location = gestureRecognizer.location(in: mapView)
		let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
		
		let onePoint = MKPointAnnotation()
		
		if !point.isEmpty {
			guard let oldPoint = point.first else {return}
			mapView.removeAnnotation(oldPoint)
			point = []
		}
		
		onePoint.coordinate = coordinate
		
		let coordinateRegion = MKCoordinateRegion(center: onePoint.coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
		mapView.setRegion(coordinateRegion, animated: true)
		mapView.addAnnotation(onePoint)
		point.append(onePoint)
		let currentLocation = CLLocation(latitude: onePoint.coordinate.latitude, longitude: onePoint.coordinate.longitude)
		
		currentLocation.lookUpLocationName { name in
			print(name)
			let popup = PopupView()
			self.view.addSubview(popup)
		}
	}
	
	private func setNavBar() {
		navigationItem.title = "Global Weather"
		navigationItem.searchController = searchController
	}
	
	private func setMapView() {
		view.addSubview(mapView)
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		mapView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		mapView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		
	}
	
	func showAlertLocation(title: String, messsage: String, url: URL?) {
		let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Настройки", style: .default) { _ in
			if let url = url {
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			}
		}
		let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
		alert.addAction(action)
		alert.addAction(cancel)
		present(alert, animated: true, completion: nil)
	}
}

extension MapViewController: CLLocationManagerDelegate {
	
	func checkLocationAuthorization(status: CLAuthorizationStatus) {
		switch status {
		case .authorizedWhenInUse:
			break
		case .denied:
			showAlertLocation(title: "Вы запретили использование местоположения",
							  messsage: "Измените это в настройках",
							  url: URL(string: UIApplication.openSettingsURLString))
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
		case .restricted:
			break
		case .authorizedAlways:
			break
		@unknown default:
			break
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		checkLocationAuthorization(status: locationManager.authorizationStatus)
	}
	
	//	 Zoom to current location
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
			let region = MKCoordinateRegion(center: location.coordinate, span: span)
			mapView.setRegion(region, animated: true)		}
	}
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkLocationAuthorization(status: locationManager.authorizationStatus)
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}
	
}

extension MapViewController: UISearchControllerDelegate {
	func updateSearchResults(for searchController: UISearchController) {
		guard let text = searchController.searchBar.text else { return }
		print(text)
	}
	
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		
	}
	
}

extension CLLocation {
	
	func lookUpLocationName(_ handler: @escaping (String) -> Void) {
		
		lookUpPlaceMark { placemark in
			if let locality = placemark?.locality {
				handler(locality)
			}
		}
	}
	
	func lookUpPlaceMark(_ handler: @escaping (CLPlacemark?) -> Void) {
		
		let geocoder = CLGeocoder()
		
		// Look up the location and pass it to the completion handler
		geocoder.reverseGeocodeLocation(self) { placemarks, error in
			
			guard error == nil else {
			
				handler(nil)
				return
			}
			if let location = placemarks?.first {
				print(location)
				handler(location)
			}
		}
	}
}

extension MapViewController: MKMapViewDelegate {
	
}

extension MapViewController: UIGestureRecognizerDelegate {
	
}
