//
//  StartupView.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//


import SwiftUI

struct StartupView: View {
    @StateObject private var viewModel = StartupViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack(spacing: 20) {
                    Image(systemName: "gamecontroller.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .foregroundColor(.accentColor)
                    ProgressView("loading_data")
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.accentColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                GameListView(hasErrorMessage: viewModel.errorMessage ?? "")            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}
