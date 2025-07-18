//
//  GameDetailViewModel.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 17/07/25.
//

import Foundation
import RealmSwift

class GameDetailViewModel: ObservableObject {
    @Published var editedTitle: String
    @Published var editedDescription: String
    @Published var showDeleteConfirmation = false

    let game: Game
    private let repository: GameRepository

    init(game: Game, repository: GameRepository = GameRepository()) {
        self.game = game
        self.repository = repository
        self.editedTitle = game.title
        self.editedDescription = game.shortDescription
    }

    func saveChanges() {
        repository.updateGame(game, title: editedTitle, description: editedDescription)
    }

    func deleteGame() {
        repository.deleteGame(game)
    }
}
