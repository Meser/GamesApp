//
//  GameRepository.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import Foundation
import RealmSwift

class GameRepository {
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    /// Saves all game data into Realm
    /// - Parameter games: Games Array data
    func save(games: [GameDTO]) {
        try! realm.write {
            for dto in games {
                let game = Game()
                game.id = dto.id
                game.title = dto.title
                game.thumbnail = dto.thumbnail
                game.platform = dto.platform
                game.shortDescription = dto.shortDescription
                game.genre = dto.genre
                game.releaseDate = dto.releaseDate
                game.publisher = dto.publisher
                realm.add(game, update: .modified)
            }
        }
    }
    
    /// Returns all games saved previously from Realm
    /// - Returns: All video games already saved
    func getAllGames() -> Results<Game> {
        realm.objects(Game.self).filter("isDeleted == false")
    }
    
    /// Deletes a specific video game
    /// - Parameter game: video game selection to delete
    func deleteGame(_ game: Game) {
        guard let thawedGame = game.thaw() else { return }
        try! realm.write {
            thawedGame.isDeleted = true
        }
    }
    
    /// Updates information of a specific video game
    /// - Parameters:
    ///   - game: game Data
    ///   - title: title of the game
    ///   - description: description of the game
    func updateGame(_ game: Game, title: String, description: String) {
        guard let thawedGame = game.thaw() else { return }
        try! realm.write {
            thawedGame.title = title
            thawedGame.shortDescription = description
        }
    }
}
