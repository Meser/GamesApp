//
//  APIService.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import Foundation

enum APIEndpoint: String {
    case games = "https://www.freetogame.com/api/games"
    // Add another cases as path
}

class APIService {
    
    /// Calls a web service and returns a decoded object
    /// - Parameters:
    ///   - path: path from web service
    ///   - completion: block to retun Result<T, Error>
    func fetch<T: Decodable>(from path: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: path.rawValue) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
