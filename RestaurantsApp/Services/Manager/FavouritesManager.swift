//
//  FavouritesManager.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation
import UIKit
import CoreData

protocol FavouritesManager: AnyObject {
    func toggleFavourite(for uuid: String)
    func isFavourite(uuid: String) -> Bool
}

class FavouritesManagerDefault: FavouritesManager {
    private var coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }

    func toggleFavourite(for uuid: String) {
        let previouslyFavourited = getPrevious(uuid: uuid)
        coreDataManager.perform { context in
            // If it was previously marked as favourite, delete from records
            if let previous = previouslyFavourited {
                context.delete(previous)
            } else {
            // Otherwise, insert new record into DB.
                let favourite = FavouriteRestaurant(context: context)
                favourite.uuid = uuid
            }
        }
    }

    func isFavourite(uuid: String) -> Bool {
        getPrevious(uuid: uuid) != nil
    }

    private func getPrevious(uuid: String) -> FavouriteRestaurant? {
        let interceptor: (NSFetchRequest<FavouriteRestaurant>) -> Void = { request in
            request.fetchLimit = 1
            request.predicate = NSPredicate(format: "uuid LIKE %@", uuid)
        }
        return coreDataManager.fetch(type: FavouriteRestaurant.self, interceptor: interceptor)?.first
    }
}
