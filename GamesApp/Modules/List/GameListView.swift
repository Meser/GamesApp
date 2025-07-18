//
//  GameListView.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import SwiftUI
import SwiftData
import SDWebImageSwiftUI

struct GameListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel: GameListViewModel
    
    init(context: ModelContext) {
        _viewModel = StateObject(wrappedValue: GameListViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredGames) { game in
                    NavigationLink(destination: GameDetailView(game: game, onUpdate: {
                        viewModel.fetchInitialGames()
                    })) {
                        HStack {
                            WebImage(url: URL(string: game.thumbnail))
                                .resizable()
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 70)
                                .cornerRadius(8)
                                .background(Color.secondary.opacity(0.1))
                            VStack(alignment: .leading) {
                                Text(game.title)
                                    .font(.headline)
                                Text(game.genre)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(game.platform)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("list_title")
            .searchable(text: $viewModel.searchText, prompt: "search_placeholder")
            .refreshable {
                await viewModel.refreshGames()
            }
        }
    }
}
