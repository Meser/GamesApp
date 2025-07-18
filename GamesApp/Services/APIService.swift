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
    static func fetch<T: Decodable>(_ type: T.Type, from endpoint: APIEndpoint) async throws -> T {
            guard let url = URL(string: endpoint.rawValue) else {
                throw URLError(.badURL)
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        }
}
