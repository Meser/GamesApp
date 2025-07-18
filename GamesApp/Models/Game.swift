//
//  Game.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import Foundation
import SwiftData

@Model
class Game: Identifiable {
    @Attribute(.unique) var id: Int
    var title: String
    var thumbnail: String
    var shortDescription: String
    var genre: String
    var platform: String
    var releaseDate: String
    var publisher: String

    init(id: Int, title: String, thumbnail: String, shortDescription: String, genre: String, platform: String, releaseDate: String, publisher: String) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.shortDescription = shortDescription
        self.genre = genre
        self.platform = platform
        self.releaseDate = releaseDate
        self.publisher = publisher
    }
}
