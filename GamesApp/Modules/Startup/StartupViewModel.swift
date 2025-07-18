//
//  StartupViewModel.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//


import Foundation

class StartupViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var errorMessage: String? = nil
    
    private let service = APIService()
    private let repository = GameRepository()
    
    /// Gets all new data from a web service and renew all games saved
    func loadData() {
        guard repository.getAllGames().isEmpty else {
            isLoading = false
            return
        }
        service.fetch(from: .games) { [weak self] (result: Result<[GameDTO], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let dtos):
                    self?.repository.save(games: dtos)
                    self?.errorMessage = nil
                case .failure(let error):
                    print("Error al descargar juegos:", error.localizedDescription)
                    self?.errorMessage = error.localizedDescription
                }
                self?.isLoading = false
            }
        }
    }
}
