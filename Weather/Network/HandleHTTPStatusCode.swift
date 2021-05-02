//
//  HandleHTTPStatusCode.swift
//  Weather
//
//  Created by Екатерина Григорьева on 28.04.2021.
//

import Foundation

extension HTTPURLResponse {
	func handleHTTPStatusCode() -> NetworkError {
		switch  statusCode {
		case 300...399:
			return .redirection
		case 400...499:
			return .clientError
		case 500...599:
			return .serverError

		default:
			return .none
		}
	}
}
