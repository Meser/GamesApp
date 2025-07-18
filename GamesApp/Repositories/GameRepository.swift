//
//  GameRepository.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import Foundation
import SwiftData

class GameRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    /// Save all data in context
    /// - Parameter games: Array of Game models
    func saveGames(_ games: [Game]) {
        for game in games {
            context.insert(game)
        }
        try? context.save()
    }
    
    /// Save changes maded to a Game model
    /// - Parameters:
    ///   - game: Game model
    ///   - title: New title to assign
    ///   - description: New description to assign
    func updateGame(_ game: Game, title: String, description: String) {
        game.title = title
        game.shortDescription = description
        try? context.save()
    }
    
    /// Delete a selected game
    /// - Parameter game: Game data to delete
    func deleteGame(_ game: Game) {
        context.delete(game)
        try? context.save()
    }
    
    /// Returns all games saved previously
    /// - Returns: All video games already saved
    func fetchAllGames() -> [Game] {
        let descriptor = FetchDescriptor<Game>(
            sortBy: [SortDescriptor(\.id)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    /// Search for specific game based on a query
    /// - Parameter query: search parameter
    /// - Returns: All games related to a query
    func searchGames(query: String) -> [Game] {
        let descriptor = FetchDescriptor<Game>(
            predicate: #Predicate { $0.title.localizedStandardContains(query) || $0.genre.localizedStandardContains(query) }
        )
        return (try? context.fetch(descriptor)) ?? []
    }
}
