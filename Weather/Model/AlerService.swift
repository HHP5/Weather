//
//  AlerService.swift
//  Weather
//
//  Created by Екатерина Григорьева on 02.05.2021.
//

import UIKit

class AlertService {
	class func alert(title: String? = nil, message: String, url: URL? = nil) -> UIAlertController {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		if url == nil {
			let action = UIAlertAction(title: "OK", style: .cancel) 
			alert.addAction(action)
			
		} else {
			
			let action = UIAlertAction(title: "Настройки", style: .default) { _ in
				if let url = url {
					UIApplication.shared.open(url, options: [:], completionHandler: nil)
				}
			}
			let cancel = UIAlertAction(title: "Отмена", style: .cancel)
			
			alert.addAction(action)
			alert.addAction(cancel)
		}
		
		return alert
	}
}
