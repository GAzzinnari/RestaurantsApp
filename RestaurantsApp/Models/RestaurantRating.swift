//
//  RestaurantRating.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation

struct RestaurantRating: Decodable {
    let thefork: Rating
    let tripadvisor: Rating
}

struct Rating: Decodable {
    let ratingValue: Double
    let reviewCount: Int
}
