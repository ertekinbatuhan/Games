//
//  GamesView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 23.09.2024.
//

import SwiftUI
import SwiftData

struct GamesView: View {
    
    @StateObject private var viewModel = GameViewModel()
    @StateObject private var favoriteGameViewModel = FavoriteGameViewModel()
    @State private var currentPage: Int = 1
    @State private var search: String = ""
    @Environment(\.modelContext) private var modelContex
    
    var body: some View {
        NavigationStack {
            VStack {
                GameTabView(currentPage: $currentPage, games: viewModel.games)
                gamesListView
            }
            .searchable(text: $search, prompt: "Search in games")
            .onChange(of: search) {
                if search.isEmpty {
                    Task {
                        await viewModel.loadGames(page: 1)
                    }
                } else {
                    Task {
                        await viewModel.searchGames(name: search, page: 1)
                    }
                }
            }
            .navigationTitle("Games")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                if viewModel.games.isEmpty {
                    Task {
                        await viewModel.loadGames(page: 1)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var gamesListView: some View {
        List(viewModel.games) { gameResult in
            gameRowView(gameResult)
        }
        .listStyle(PlainListStyle())
    }
    
    @ViewBuilder
    private func gameRowView(_ gameResult: GameResult) -> some View {
        NavigationLink(destination: GameDetailView(gameId: gameResult.id ?? 0)) {
            GameRowView(game: gameResult)
        }
        .swipeActions {
            favoriteButtonView(gameResult)
        }
        .onAppear {
            if viewModel.games.last?.id == gameResult.id && !viewModel.isLoading {
                Task {
                    await viewModel.loadGames(page: viewModel.currentPage + 1)
                }
            }
        }
    }
    
    @ViewBuilder
    private func favoriteButtonView(_ gameResult: GameResult) -> some View {
        Button(action: {
            favoriteGameViewModel.addFavoriteGame(
                id: gameResult.id,
                name: gameResult.name,
                released: gameResult.released,
                backgroundImage: gameResult.backgroundImage,
                rating: gameResult.rating,
                context: modelContex
            )
        }) {
            Label("Add Favorites", systemImage: "heart")
        }
        .tint(.red)
    }
}

#Preview {
    GamesView()
}
