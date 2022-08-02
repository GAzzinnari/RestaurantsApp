//
//  CoreDataManager.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = .init()

    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "RestaurantsApp"))  {
        self.persistentContainer = persistentContainer
    }

    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    /// Initializes persistent container to be used across application. Only call once on app launch.
    func initialize(completion: @escaping (Result<Void, Error>) -> Void) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            print(storeDescription)
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    /// Allows closure (taking the `NSManagedObjectContext` as parameter) to be passed.
    /// Cclosure is invoked and later context is saved if required.
    func perform(update: (NSManagedObjectContext) -> Void) {
        update(persistentContainer.viewContext)
        saveContext()
    }

    func fetch<T>(type: T.Type, entityName: String = String(describing: T.self), interceptor: ((NSFetchRequest<T>) -> Void)?) -> [T]? where T: NSFetchRequestResult {
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        interceptor?(request)
        return try? context.fetch(request)
    }

    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
