//
//  CoreDataManagerMock.swift
//  RestaurantsAppTests
//
//  Created by Gabriel Azzinnari on 5/8/22.
//

import CoreData
@testable import RestaurantsApp

class CoreDataManagerMock: CoreDataManager {
    var didCallPerform: Bool = false
    var didCallFetch: Bool = false
    var didCallInitialize: Bool = false

    var stubbedPerformUpdateContext: NSManagedObjectContext?
    var stubbedInitializeResult: Result<Void, Error>?
    var stubbedFetchResult: [Any] = []

    override func perform(update: (NSManagedObjectContext) -> Void) {
        didCallPerform = true
        if let context = stubbedPerformUpdateContext {
            update(context)
        }
    }

    override func fetch<T>(type: T.Type,
                           entityName: String = String(describing: T.self),
                           interceptor: ((NSFetchRequest<T>) -> Void)?) -> [T]? where T : NSFetchRequestResult {
        didCallFetch = true
        return stubbedFetchResult as? [T]
    }

    override func initialize(completion: @escaping (Result<Void, Error>) -> Void) {
        didCallInitialize = true
        if let result = stubbedInitializeResult {
            completion(result)
        }
    }
}
