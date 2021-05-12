//
//  PopupViewModelType.swift
//  Weather
//
//  Created by Екатерина Григорьева on 25.04.2021.
//

import Foundation

protocol PopupViewModelType {
	var locality: String? {get}
	var coordinate: String {get}
	func getCityNameAndCoordinate()
	var didFindLocality: (() -> Void)? {get set}

}
