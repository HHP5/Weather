//
//  SceneDelegate.swift
//  Weather
//
//  Created by Екатерина Григорьева on 21.04.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(windowScene: windowScene)
		
		window?.overrideUserInterfaceStyle = .light

		window?.makeKeyAndVisible()
		let mapViewController = MapViewController(viewModel: MapViewModel())
		
		let navBar = UINavigationController(rootViewController: mapViewController)
		window?.rootViewController = navBar
		
	}
}
