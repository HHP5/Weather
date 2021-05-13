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
	
	// MARK: - Properties
	private var viewModel: MapViewModelType
	
	private var popupView: PopupView?
	
	private var isPopupAdded: Bool = false
	
	private let searchController: UISearchController = {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search for places"
		searchController.searchBar.backgroundColor = .clear
		searchController.searchBar.tintColor = .black
		return searchController
	}()
	
	private let locationManager: CLLocationManager = {
		let locationManager = CLLocationManager()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 10
		return locationManager
	}()
	
	private var currentLocation: CLLocation = CLLocation()
	
	// MARK: - Init
	
	init(viewModel: MapViewModelType) {
		self.viewModel = viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - IBOutlets
	
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
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		searchController.delegate = self
		locationManager.delegate = self
		mapView.delegate = self
		searchController.searchBar.delegate = self
		
		setupNavigationBar()
		setupMapView()
		setupGestureRecognizer()
		//		setupPopup()
		
		checkLocationAuthorization(status: locationManager.authorizationStatus)
		locationManager.requestWhenInUseAuthorization()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		//		setupPopup()
	}
	
	// MARK: - Actions (@ojbc + @IBActions)
	
	@objc private func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
		
		let location = gestureRecognizer.location(in: mapView)
		let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
		
		self.makePoint(in: coordinate)
		self.locationManager(locationManager, didUpdateLocations: coordinate)
	}
	
	// MARK: - Private Methods
	
	private func closePopup() {
		
		removeAnnotationsIfNeeded()
//		popupView?.removeFromSuperview()
		popupView?.alpha = 0
		popupView?.isHidden = true
	}
	
	private func removeAnnotationsIfNeeded() {
		if !mapView.annotations.isEmpty {
			mapView.removeAnnotations(mapView.annotations)
		}
	}
	
	private func setupGestureRecognizer() {
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		gestureRecognizer.delegate = self
		mapView.addGestureRecognizer(gestureRecognizer)
	}
	
	private func makePoint(in coordinate: CLLocationCoordinate2D) {
		closePopup()
		
		let point = MKPointAnnotation()
		point.coordinate = coordinate
		
		mapView.addAnnotation(point)
		currentLocation = CLLocation(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
		
		addPopup()
	}
	
	private func addPopup() {
		viewModel.coordinateInPoint(location: currentLocation) { [weak self] model in
			guard let self = self else {return}
			
			self.popupView = PopupView(viewModel: model)
			
//			guard let popupView = self.popupView else {return}
//			popupView.delegate = self
			print(#function)
			if self.isPopupAdded {
				self.popupView?.isHidden = false
				self.popupView?.alpha = 1
			} else {
				self.setupPopup()
				
			}
		}
	}
	
	private func setupNavigationBar() {
		navigationItem.title = "Global Weather"
		navigationItem.searchController = searchController
	}
	
	private func setupPopup() {
		guard let popupView = popupView else { return  }
		print(#function)
		popupView.delegate = self
		
		view.addSubview(popupView)
		
		popupView.snp.makeConstraints { make in
			make.height.equalTo(170)
			make.bottom.equalToSuperview().offset(-20)
			make.left.equalToSuperview().offset(30)
			make.right.equalToSuperview().offset(-30)
		}
		popupView.isHidden = true
		popupView.alpha = 1
		isPopupAdded = true
	
	}
	
	private func setupMapView() {
		view.addSubview(mapView)
		
		mapView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.bottom.equalToSuperview()
			make.left.right.equalToSuperview()
		}	
	}
	
}

// MARK: - CLLocationManagerDelegate

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
// MARK: - UISearchBarDelegate

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

// MARK: - PopupButtonDelegate

extension MapViewController: PopupButtonDelegate {
	func didPressButton(button: PopupButton) {
		
		switch button {
		
		case .close:
			
			closePopup()
			
		case .showWeather:
			
			let weatherViewMode = viewModel.weatherPoint(location: currentLocation)
			let destinationVC = WeatherViewController(viewModel: weatherViewMode)
			destinationVC.modalPresentationStyle = .fullScreen
			self.navigationController?.pushViewController(destinationVC, animated: true)
			
			closePopup()
			searchController.isActive = false
		}
	}
}
