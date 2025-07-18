//
//  GameDTO.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import Foundation

// Decodable Object
struct GameDTO: Decodable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let genre: String
    let platform: String
    let releaseDate: String
    let publisher: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case shortDescription = "short_description"
        case genre
        case platform
        case releaseDate = "release_date"
        case publisher
    }
}

// Parse DTO to swiftData model
extension GameDTO {
    func toDomain() -> Game {
        Game(
            id: id,
            title: title,
            thumbnail: thumbnail,
            shortDescription: shortDescription,
            genre: genre,
            platform: platform,
            releaseDate: releaseDate,
            publisher: publisher
        )
    }
}
