//
//  RestaurantCellViewModel.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation
import UIKit

class RestaurantCellViewModel {
    // MARK: Properties / constants
    private let restaurant: Restaurant
    private let favouritesManager: FavouritesManager

    private var isFavourite: Bool {
        favouritesManager.isFavourite(uuid: restaurant.uuid)
    }
    private var uuid: String {
        restaurant.uuid
    }
    var title: String {
        restaurant.name
    }
    var subtitle: String {
        "\(restaurant.address.street), \(restaurant.address.locality), \(restaurant.address.country)"
    }
    var imageUrl: URL? {
        restaurant.mainPhoto.map { URL(string: $0.thumbnail) } ?? nil
    }
    var rating: String {
        "\(restaurant.aggregateRatings.thefork.ratingValue)"
    }
    var favouriteImage: UIImage? {
        isFavourite ? AppImage.heartFilled : AppImage.heartEmpty
    }

    // MARK: Bindings
    var onUpdate: () -> Void = { }

    init(restaurant: Restaurant,
         favouritesManager: FavouritesManager = FavouritesManagerDefault()) {
        self.restaurant = restaurant
        self.favouritesManager = favouritesManager
    }

    @objc
    func favouriteTapped() {
        favouritesManager.toggleFavourite(for: restaurant.uuid)
        onUpdate()
    }
}
