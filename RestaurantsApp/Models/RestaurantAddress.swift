//
//  RestaurantAddress.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation

struct RestaurantAddress: Decodable {
    let street: String
    let locality: String
    let country: String
}
