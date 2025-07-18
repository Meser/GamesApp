//
//  Game.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import RealmSwift

// Realm model
class Game: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var thumbnail: String
    @Persisted var shortDescription: String
    @Persisted var genre: String
    @Persisted var platform: String
    @Persisted var isDeleted: Bool = false
    @Persisted var releaseDate: String
    @Persisted var publisher: String
}
