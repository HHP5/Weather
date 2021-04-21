//
//  ViewController.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController {

	private let map = MKMapView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		

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

