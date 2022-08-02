//
//  Restaurant.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation

struct Restaurant: Decodable {
    let name: String
    let uuid: String
    let currenciesAccepted: String
    let servesCuisine: String
    let address: RestaurantAddress
    let aggregateRatings: RestaurantRating
    let mainPhoto: RestaurantPhotos?
}
