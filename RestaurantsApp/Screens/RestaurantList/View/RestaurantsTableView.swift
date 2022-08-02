//
//  RestaurantsTableView.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import UIKit

class RestaurantsTableView: UITableView {
    private var restaurants: [RestaurantCellViewModel] = []

    var onPullToRefresh: () -> Void = { }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
        setupPullToRefresh()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public methods
    func update(restaurants: [RestaurantCellViewModel]) {
        self.restaurants = restaurants
        refreshControl?.endRefreshing()
        reloadData()
    }
}

// MARK: Setup methods
private extension RestaurantsTableView {
    func setupTableView() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        rowHeight = UITableView.automaticDimension
        allowsSelection = false
        register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.identifier)
    }

    func setupPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
    }

    @objc
    func refreshTriggered() {
        onPullToRefresh()
    }
}

// MARK: TableView delegates
extension RestaurantsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < restaurants.count,
              let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.identifier),
              let restaurantCell = cell as? RestaurantCell else {
            return UITableViewCell()
        }
        let restaurantViewModel = restaurants[indexPath.row]
        restaurantCell.setup(viewModel: restaurantViewModel)

        return restaurantCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
