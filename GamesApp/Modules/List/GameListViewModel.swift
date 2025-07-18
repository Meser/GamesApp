//
//  GameListViewModel.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import Foundation
import SwiftData
import Combine

@MainActor
class GameListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredGames: [Game] = []
    @Published var errorMessage: String? = nil

    private var allGames: [Game] = []
    private let context: ModelContext
    private var cancellables = Set<AnyCancellable>()

    init(context: ModelContext) {
        self.context = context
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterGames()
            }
            .store(in: &cancellables)
        fetchInitialGames()
    }
    
    /// Returns all Game objects fetched
    func fetchInitialGames() {
        let descriptor = FetchDescriptor<Game>(
            sortBy: [SortDescriptor(\.id)]
        )
        self.allGames = (try? context.fetch(descriptor)) ?? []
        self.filteredGames = allGames
    }

    private func filterGames() {
        let query = searchText.lowercased()
        if query.isEmpty {
            filteredGames = allGames
        } else {
            filteredGames = allGames.filter {
                $0.title.lowercased().contains(query) ||
                $0.genre.lowercased().contains(query) ||
                ($0.platform.lowercased().contains(query))
            }
        }
    }

    
    /// Gets all new data from a web service and renew all games saved
    func refreshGames() async {
        do {
            let dtos = try await APIService.fetch([GameDTO].self, from: .games)
            let newGames = dtos.map { $0.toDomain() }

            let repository = GameRepository(context: context)
            repository.saveGames(newGames)

            fetchInitialGames()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
