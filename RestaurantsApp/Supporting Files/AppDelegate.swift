//
//  AppDelegate.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var mainCoordinator: MainCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        mainCoordinator = MainCoordinator(window: window)
        mainCoordinator?.start()
        return true
    }
}
