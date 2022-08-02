//
//  CoreDataMockBuilder.swift
//  RestaurantsAppTests
//
//  Created by Gabriel Azzinnari on 5/8/22.
//

import CoreData

class CoreDataMockBuilder {
    static func buildContainer() -> NSPersistentContainer {
        let bundle = Bundle(for: Self.self)
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [bundle])!
        let container = NSPersistentContainer(name: "RestaurantsApp", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load persistent stores \(error)")
            }
        }
        return container
    }

    static func buildContext() -> NSManagedObjectContext {
        buildContainer().viewContext
    }
}
