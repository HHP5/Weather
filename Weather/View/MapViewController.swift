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
	private var popupView = PopupView()
	private let searchController: UISearchController = {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search for places"
		searchController.searchBar.backgroundColor = .clear
		searchController.searchBar.tintColor = .black
		return searchController
	}()
	
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
		mapView.delegate = self
		searchController.searchBar.delegate = self
		
		setupNavigationBar()
		setupMapView()
		setupGestureRecognizer()
		setupPopup()
		
	}
	
	// MARK: - Actions (@ojbc + @IBActions)
	
	@objc
	private func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
		
		let location = gestureRecognizer.location(in: mapView)
		let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
		
		self.makePoint(in: coordinate)
		self.zoomToLocation(didUpdateLocations: coordinate)
	}
	
	// MARK: - Private Methods
	private func zoomToLocation(didUpdateLocations coordinate: CLLocationCoordinate2D) {
		
		let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
		mapView.setRegion(coordinateRegion, animated: true)
		
	}

	private func closePopup() {
		
		removeAnnotationsIfNeeded()
		popupView.alpha = 0
		
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
		self.searchController.searchBar.endEditing(true)
		
		let point = MKPointAnnotation()
		point.coordinate = coordinate
		
		mapView.addAnnotation(point)
		viewModel.currentLocation = CLLocation(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
		
		addPopup()
	}
	
	private func addPopup() {
		
		viewModel.coordinateInPoint()
		
		viewModel.onDidUpdatePopupViewModel = { [weak self] model in
			guard let self = self else {return}
			self.popupView.viewModel = model
			self.popupView.alpha = 1
		}
	}
	
	private func setupNavigationBar() {
		navigationItem.title = "Global Weather"
		navigationItem.searchController = searchController
	}
	
	private func setupPopup() {
		self.popupView.delegate = self		
		view.addSubview(popupView)
		
		popupView.snp.makeConstraints { make in
			make.height.equalTo(170)
			make.bottom.equalToSuperview().offset(-20)
			make.leading.trailing.equalToSuperview().inset(20)
		}
		
		popupView.alpha = 0
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

// MARK: - UISearchBarDelegate

extension MapViewController: UISearchBarDelegate {
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		closePopup()
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.closePopup()
		self.searchController.searchBar.endEditing(true)
		guard let text = searchController.searchBar.text else { return }
		
		viewModel.search(for: text)
		
		viewModel.onDidUpdateCurrentLocation = { [weak self] coordinate in
			guard let self = self else {return}
			self.zoomToLocation(didUpdateLocations: coordinate)
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				self.makePoint(in: coordinate)
				self.searchController.dismiss(animated: true, completion: nil)
			}
		}
		
		viewModel.notFoundAnyLocality = { [weak self] alert in
			self?.present(alert, animated: true, completion: nil)
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
			
			let weatherViewMode = viewModel.weatherPoint()
			let destinationVC = WeatherViewController(viewModel: weatherViewMode)
			self.navigationController?.pushViewController(destinationVC, animated: true)
			
			closePopup()
			searchController.isActive = false
		}
	}
}
