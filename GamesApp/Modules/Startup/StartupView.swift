//
//  StartupView.swift
//  GamesApp
//
//  Created by Juan Hernandez Galvan on 16/07/25.
//

import SwiftUI
import SwiftData

struct StartupView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel: StartupViewModel
    
    init(context: ModelContext) {
        _viewModel = StateObject(wrappedValue: StartupViewModel(context: context))
    }
    
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
                if viewModel.errorMessage != nil {
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
                                await viewModel.loadData()
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
                    GameListView(context: context)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}
