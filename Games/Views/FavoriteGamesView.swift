//
//  FavoriteGameView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 26.09.2024.
//

import SwiftUI
import SwiftData
import Lottie

struct FavoriteGamesView: View {
    @Query(sort: [SortDescriptor(\FavoriteGame.released, order: .reverse)], animation: .snappy)
    private var favoriteGames: [FavoriteGame]
    @State private var search: String = ""
    @StateObject private var favoriteGameViewModel = FavoriteGameViewModel()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    if favoriteGameViewModel.filteredGames.isEmpty {
                        GeometryReader { geometry in
                            LottieView(animation: .named("nodata")).looping()
                                .frame(width: 250, height: 250)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }
                        .frame(height: 600)
                    } else {
                        ForEach(favoriteGameViewModel.filteredGames) { game in
                            NavigationLink(destination: GameDetailView(gameId: game.id ?? 0)) {
                                FavoriteGameCardView(game: game)
                                    .environmentObject(favoriteGameViewModel)
                            }
                        }
                    }
                }
                .padding()
            }
            .searchable(text: $search)
            .onChange(of: search) {
                favoriteGameViewModel.searchFavoriteGames(with: search, from: favoriteGames)
            }
            .onAppear {
                favoriteGameViewModel.filteredGames = favoriteGames
            }
            .navigationTitle("Favorite Games")
        }
    }
}

#Preview {
    FavoriteGamesView()
}
