//
//  ViewController.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

class MapViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate, UISearchControllerDelegate {
	private var viewModel: MapViewModelType
	
	init(viewModel: MapViewModelType) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private var popupView: PopupView? {
		willSet(popupView) {
			
			guard let popupView = popupView else { return }
			popupView.showWeatherButton.addTarget(self, action: #selector(showWeather), for: .touchUpInside)
			popupView.closeButton.addTarget(self, action: #selector(closePopup), for: .allEvents)
			
		}
	}
	
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
		locationManager.distanceFilter = 10
		return locationManager
	}()
	
	private let searchController: UISearchController = {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search for places"
		searchController.searchBar.backgroundColor = .clear
		searchController.searchBar.tintColor = .black
		return searchController
	}()
	
	var currentLocation: CLLocation = CLLocation()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		searchController.delegate = self
		locationManager.delegate = self
		mapView.delegate = self
		searchController.searchBar.delegate = self
		
		setNavBar()
		setMapView()
		setGestureRecognizer()
		
		checkLocationAuthorization(status: locationManager.authorizationStatus)
		locationManager.requestWhenInUseAuthorization()
		
	}

	@objc private func showWeather() {
		
		let city = viewModel.weatherPoint(location: currentLocation)
		let destinationVC = WeatherViewController(viewModel: city)
		destinationVC.modalPresentationStyle = .fullScreen
		self.navigationController?.pushViewController(destinationVC, animated: true)
		
		popupView?.removeFromSuperview()
		
		if !mapView.annotations.isEmpty {
			mapView.removeAnnotations(mapView.annotations)
		}
		
		searchController.isActive = false
		
	}
	
	@objc private func closePopup() {
		if !mapView.annotations.isEmpty {
			mapView.removeAnnotations(mapView.annotations)
		}
		popupView?.removeFromSuperview()
	}
	
	private func setGestureRecognizer() {
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		gestureRecognizer.delegate = self
		mapView.addGestureRecognizer(gestureRecognizer)
	}
	
	@objc private func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
		
		let location = gestureRecognizer.location(in: mapView)
		let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
		
		self.makePoint(in: coordinate)
		self.locationManager(locationManager, didUpdateLocations: coordinate)
	}
	
	private func makePoint(in coordinate: CLLocationCoordinate2D) {
		let point = MKPointAnnotation()
		point.coordinate = coordinate
		
		mapView.addAnnotation(point)
		currentLocation = CLLocation(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
		
		addPopup()
	}
	
	private func addPopup() {
		viewModel.coordinateInPoint(location: currentLocation) { [weak self] model in
			self?.popupView = PopupView(viewModel: model)
			
			guard let popupView = self?.popupView else {return}
			self?.view.addSubview(popupView)
		}
	}
	
	private func setNavBar() {
		navigationItem.title = "Global Weather"
		navigationItem.searchController = searchController
	}
	
	private func setMapView() {
		view.addSubview(mapView)
		
		mapView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.bottom.equalToSuperview()
			make.left.right.equalToSuperview()
		}	
	}
	
}

extension MapViewController: CLLocationManagerDelegate {
	
	func checkLocationAuthorization(status: CLAuthorizationStatus) {
		switch status {
		case .authorizedWhenInUse:
			break
		case .denied:
			let alert = AlertService.alert(title: "Вы запретили использование местоположения",
										   message: "Измените это в настройках",
										   url: URL(string: UIApplication.openSettingsURLString))
			self.present(alert, animated: true)
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
	func locationManager(_ manager: CLLocationManager, didUpdateLocations coordinate: CLLocationCoordinate2D) {
		
		let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
		mapView.setRegion(coordinateRegion, animated: true)
		
	}
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkLocationAuthorization(status: locationManager.authorizationStatus)
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		let alert = AlertService.alert(message: error.localizedDescription)
		present(alert, animated: true)
	}
	
}

extension MapViewController: UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.closePopup()
		self.searchController.searchBar.endEditing(true)
		guard let text = searchController.searchBar.text else { return }
		
		viewModel.searchBarSearchButtonClicked(for: text) { [weak self] coordinate in
			
			guard let self = self else {return}
			
			self.locationManager(self.locationManager, didUpdateLocations: coordinate)
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				self.makePoint(in: coordinate)
				self.searchController.dismiss(animated: true, completion: nil)
			}
			
		}
	}
	
}
