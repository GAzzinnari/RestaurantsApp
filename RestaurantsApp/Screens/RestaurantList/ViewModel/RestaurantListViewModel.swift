//
//  RestaurantListViewModel.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation

enum RestaurantListSortCriteria {
    case name
    case rating
    case none
}

protocol RestaurantListViewModelable: AnyObject {
    var onRestaurantsFetched: ([RestaurantCellViewModel]) -> Void { get set }
    var onError: (Error) -> Void { get set }
    var onLoad: () -> Void { get set }

    func fetchRestaurants()
    func updateSortCriteria(_ criteria: RestaurantListSortCriteria)
}

class RestaurantListViewModel: RestaurantListViewModelable {
    // MARK: Properties
    private let restaurantsService: RestaurantsRepository

    private var restaurants: [Restaurant] = []
    private var sortType: RestaurantListSortCriteria = .none

    // MARK: Bindings
    var onRestaurantsFetched: ([RestaurantCellViewModel]) -> Void = { _ in }
    var onError: (Error) -> Void = { _ in }
    var onLoad: () -> Void = { }

    init(restaurantsService: RestaurantsRepository = RestaurantsRepositoryDefault()) {
        self.restaurantsService = restaurantsService
    }

    func fetchRestaurants() {
        restaurantsService.getRestaurants { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newRestaurants):
                self.restaurants = newRestaurants
                self.updateList()
            case .failure(let error):
                self.showError(error: error)
            }
        }
    }

    func updateSortCriteria(_ criteria: RestaurantListSortCriteria) {
        sortType = criteria
        updateList()
    }
}

extension RestaurantListViewModel {
    private func updateList() {
        var sortedRestaurants: [Restaurant]
        switch sortType {
        case .rating:
            sortedRestaurants = restaurants.sorted { $0.aggregateRatings.thefork.ratingValue > $1.aggregateRatings.thefork.ratingValue }
        case .name:
            sortedRestaurants = restaurants.sorted { $0.name < $1.name }
        case .none:
            sortedRestaurants = restaurants
        }
        let restaurantViewModels = sortedRestaurants.map { RestaurantCellViewModel(restaurant: $0) }
        onRestaurantsFetched(restaurantViewModels)
    }

    private func showError(error: Error) {
        onError(error)
    }
}
