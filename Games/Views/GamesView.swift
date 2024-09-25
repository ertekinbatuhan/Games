//
//  GamesView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 23.09.2024.
//

import SwiftUI

struct GamesView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var currentPage: Int = 0

    var body: some View {
        NavigationStack {
            VStack {
                GameTabView(games: viewModel.games, currentPage: $currentPage)

                List(viewModel.games) { game in
                    GameRowView(game: game)
                        .onAppear {
                            if viewModel.games.last == game && !viewModel.isLoading {
                                viewModel.loadGames(page: viewModel.currentPage + 1)
                            }
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Games").navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.loadGames(page: 1)
            }
        }
    }
}

#Preview {
    GamesView()
}
