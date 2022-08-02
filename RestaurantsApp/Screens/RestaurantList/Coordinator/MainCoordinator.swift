//
//  MainCoordinator.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation
import UIKit

class MainCoordinator {
    private weak var navigation: UINavigationController?
    private weak var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        CoreDataManager.shared.initialize { [weak self] result in
            self?.showRestaurantList()
        }
    }

    private func showRestaurantList() {
        let viewModel = RestaurantListViewModel()
        let controller = RestaurantListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        self.navigation = navigationController
    }
}
