//
//  StartupViewModel.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import Foundation
import SwiftData

@MainActor
class StartupViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var errorMessage: String? = nil
    @Published var hasSavedData: Bool = false

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    // Gets all new data from a web service and renew all games saved
    func loadData() async {
        let repository = GameRepository(context: context)
        guard repository.fetchAllGames().isEmpty else {
            isLoading = false
            return
        }
        do {
            let dtos = try await APIService.fetch([GameDTO].self, from: .games)
            let games = dtos.map { $0.toDomain() }
            repository.saveGames(games)
            errorMessage = nil
        } catch {
            print("Error al descargar juegos:", error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
