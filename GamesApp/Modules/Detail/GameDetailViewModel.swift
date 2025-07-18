//
//  GameDetailViewModel.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 17/07/25.
//

import Foundation
import SwiftData

@MainActor
class GameDetailViewModel: ObservableObject {
    @Published var editedTitle: String
    @Published var editedDescription: String
    @Published var showDeleteConfirmation = false

    let game: Game
    private var context: ModelContext

    init(game: Game, context: ModelContext) {
        self.game = game
        self.context = context
        self.editedTitle = game.title
        self.editedDescription = game.shortDescription
    }

    func setContext(_ context: ModelContext) {
        self.context = context
    }
    
    func applyChanges() {
        game.title = editedTitle
        game.shortDescription = editedDescription
        try? context.save()
    }

    func delete() {
        context.delete(game)
        try? context.save()
    }
}
