//
//  RestaurantPhotos.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation

struct RestaurantPhotos: Decodable {
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case thumbnail = "92x92"
    }
}
