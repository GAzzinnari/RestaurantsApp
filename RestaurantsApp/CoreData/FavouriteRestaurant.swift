//
//  FavouriteRestaurant.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation
import CoreData

@objc(FavouriteRestaurant)
class FavouriteRestaurant: NSManagedObject {
    @NSManaged var uuid: String!
}
