//
//  GameDetailView.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import SwiftUI
import RealmSwift
import SDWebImageSwiftUI

struct GameDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: GameDetailViewModel
    var onUpdate: (() -> Void)?

    init(game: Game, onUpdate: (() -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: GameDetailViewModel(game: game))
        self.onUpdate = onUpdate
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                WebImage(url: URL(string: viewModel.game.thumbnail))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .padding(.horizontal)
                VStack(alignment: .leading, spacing: 16) {
                    HeadlineText(localizedText: "game_title")
                    StyledTextEditor(text: $viewModel.editedTitle, size: .small)
                    HeadlineText(localizedText: "description_title")
                    StyledTextEditor(text: $viewModel.editedDescription, size: .large)
                    HeadlineText(localizedText: "publisher_title")
                    BodyText(text: viewModel.game.publisher)
                    HeadlineText(localizedText: "release_date_title")
                    BodyText(text: viewModel.game.releaseDate)
                }
                .padding(.horizontal)
                
                Button(action: {
                    viewModel.saveChanges()
                    onUpdate?()
                    dismiss()
                }) {
                    Text("save_changes")
                        .frame(maxWidth: .infinity, minHeight: 40)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .navigationTitle("detail_title")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(role: .destructive) {
                    viewModel.showDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .alert("delete_game", isPresented: $viewModel.showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                viewModel.deleteGame()
                onUpdate?()
                dismiss()
            }
            Button("cancel_title", role: .cancel) { }
        }
    }
}
