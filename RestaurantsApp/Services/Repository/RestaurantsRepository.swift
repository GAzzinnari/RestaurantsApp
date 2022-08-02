//
//  RestaurantsRepository.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation

protocol RestaurantsRepository {
    /// Retreives restaurants from remote location, invokes completion with result indicating operation success.
    func getRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void)
}

class RestaurantsRepositoryDefault: RestaurantsRepository {
    // MARK: Properties
    private let networkHelper: NetworkHelper

    // MARK: Constants
    private let getRestaurantsURL: String = "https://alanflament.github.io/TFTest/test.json"


    init(networkHelper: NetworkHelper = NetworkHelperDefault()) {
        self.networkHelper = networkHelper
    }

    func getRestaurants(completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        networkHelper.get(url: getRestaurantsURL,
                          type: RestaurantsDTO.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: Internal type
private extension RestaurantsRepositoryDefault {
    struct RestaurantsDTO: Decodable {
        let data: [Restaurant]
    }
}
