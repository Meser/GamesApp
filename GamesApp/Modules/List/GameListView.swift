//
//  GameListView.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameListView: View {
    @StateObject private var viewModel = GameListViewModel()
    var hasErrorMessage: String
    
    var body: some View {
        NavigationView {
            if viewModel.errorMessage != nil || hasErrorMessage.count > 0 {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.yellow)
                    HeadlineText(localizedText: "failed_data")
                    Text(viewModel.errorMessage ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Button(action: {
                        Task {
                                await viewModel.refreshGames()
                            }
                    }) {
                        Text("retry_title")
                            .frame(maxWidth: .infinity, minHeight: 40)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.games) { game in
                        NavigationLink(destination: GameDetailView(
                            game: game,
                            onUpdate: {
                                viewModel.filterGames()
                            })
                        )
                        {
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
}
