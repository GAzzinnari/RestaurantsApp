//
//  RestaurantListViewController.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation
import UIKit

class RestaurantListViewController: UIViewController {
    // MARK: Properties
    private let viewModel: RestaurantListViewModelable

    // MARK: Subviews
    private let filtersView: RestaurantFiltersView = RestaurantFiltersView()
    private let tableView: RestaurantsTableView = RestaurantsTableView()

    // MARK: Initializers
    init(viewModel: RestaurantListViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle events
    override func viewDidLoad() {
        title = "Restaurant List"
        setupSubviews()
        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchRestaurants()
    }

    private func setupBindings() {
        viewModel.onRestaurantsFetched = { [weak self] restaurants in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.update(restaurants: restaurants)
            }

        }
        viewModel.onLoad = {
            // TODO: Implement
        }
        viewModel.onError = {_ in
            // TODO: Implement
        }
        tableView.onPullToRefresh = { [weak self] in
            self?.viewModel.fetchRestaurants()
        }
        filtersView.onNameSortTapped = { [weak self] in
            self?.viewModel.updateSortCriteria(.name)
        }
        filtersView.onRatingSortTapped = { [weak self] in
            self?.viewModel.updateSortCriteria(.rating)
        }
        filtersView.onNoneSortTapped = { [weak self] in
            self?.viewModel.updateSortCriteria(.none)
        }
    }

    private func setupSubviews() {
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        filtersView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(filtersView)
        NSLayoutConstraint.activate([
            filtersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filtersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filtersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: filtersView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
