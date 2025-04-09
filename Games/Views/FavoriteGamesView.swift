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
                contentView
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
    
    @ViewBuilder
    private var contentView: some View {
        LazyVStack(spacing: 20) {
            if favoriteGameViewModel.filteredGames.isEmpty {
                emptyStateView
            } else {
                favoriteGamesList
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var emptyStateView: some View {
        GeometryReader { geometry in
            LottieView(animation: .named("nodata")).looping()
                .frame(width: 250, height: 250)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(height: 600)
    }
    
    @ViewBuilder
    private var favoriteGamesList: some View {
        ForEach(favoriteGameViewModel.filteredGames) { game in
            gameNavigationLink(for: game)
        }
    }
    
    @ViewBuilder
    private func gameNavigationLink(for game: FavoriteGame) -> some View {
        NavigationLink(destination: GameDetailView(gameId: game.id ?? 0)) {
            FavoriteGameCardView(game: game)
                .environmentObject(favoriteGameViewModel)
        }
    }
}

#Preview {
    FavoriteGamesView()
}
