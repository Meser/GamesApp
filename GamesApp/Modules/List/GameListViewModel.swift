//
//  GameListViewModel.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import Foundation
import Combine
import RealmSwift

class GameListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var games: [Game] = []
    @Published var errorMessage: String? = nil
    
    private let repository = GameRepository()
    private var allGames: Results<Game>
    private var token: NotificationToken?
    private var cancellables = Set<AnyCancellable>()
    private let service = APIService()
    
    init() {
        allGames = repository.getAllGames()
        
        token = allGames.observe { [weak self] _ in
            self?.filterGames()
        }
        
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterGames()
            }
            .store(in: &cancellables)
        
        filterGames()
    }
    
    /// Returns video games data even if user filtered it
    func filterGames() {
        let lower = searchText.lowercased()
        if lower.isEmpty {
            games = Array(allGames)
        } else {
            games = allGames.filter {
                $0.platform.lowercased().contains(lower) ||
                $0.title.lowercased().contains(lower) ||
                $0.genre.lowercased().contains(lower)
            }.map { $0 }
        }
    }
    
    /// Gets all new data from a web service and renew all games saved
    @MainActor
    func refreshGames() async {
        do {
            let dtos = try await withCheckedThrowingContinuation { continuation in
                service.fetch(from: .games) { (result: Result<[GameDTO], Error>) in
                    continuation.resume(with: result)
                }
            }
            repository.save(games: dtos)
            filterGames()
            errorMessage = nil
        } catch {
            print("Error al actualizar:", error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
}
