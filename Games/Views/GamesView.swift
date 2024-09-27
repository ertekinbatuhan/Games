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
                GameTabView(games: viewModel.games, currentPage: $currentPage)
                
                List(viewModel.games) { game in
                    NavigationLink(destination: GameDetailView(gameId: game.id ?? 0)) {
                        GameRowView(game: game)
                    }
                    .swipeActions {
                        Button(action: {
                            // Favori oyunu ekle
                            favoriteGameViewModel.addFavoriteGame(
                                id: game.id,
                                name: game.name,
                                released: game.released,
                                backgroundImage: game.backgroundImage,
                                rating: game.rating,
                                context: modelContex
                            )
                        }) {
                            Label("Add Favorites", systemImage: "heart")
                        }
                        .tint(.red)
                    }
                    .onAppear {
                        if viewModel.games.last?.id == game.id && !viewModel.isLoading {
                            viewModel.loadGames(page: viewModel.currentPage + 1)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .searchable(text: $search, prompt: "Search in games")
            .onChange(of: search) {
                if search.isEmpty {
                    viewModel.loadGames(page: 1)
                } else {
                    viewModel.searchGames(name: search, page: 1)
                }
            }
            .navigationTitle("Games")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                if viewModel.games.isEmpty {
                    viewModel.loadGames(page: 1)
                }
            }
        }
    }
}

#Preview {
    GamesView()
}
