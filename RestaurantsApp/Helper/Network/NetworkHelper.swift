//
//  NetworkHelper.swift
//  RestaurantsApp
//
//  Created by Gabriel Azzinnari on 2/8/22.
//

import Foundation

protocol NetworkHelper {
    func get<T: Decodable>(url urlString: String, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkHelperDefault: NetworkHelper {
    func get<T>(url urlString: String, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.underlyingError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.errorStatus))
                return
            }
            guard let data = data, let result = try? JSONDecoder().decode(type, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(result))
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case internalServerError
    case invalidUrl
    case errorStatus
    case decodingError
    case underlyingError
}
