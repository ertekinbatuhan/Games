//
//  GameDetailView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 25.09.2024.
//

import SwiftUI

struct GameDetailView: View {
    @StateObject private var viewModel = GameDetailViewModel()
    let gameId: Int
    
    var body: some View {
        ScrollView {
            contentView
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            Task {
                await viewModel.loadGameDetail(id: gameId)
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        ZStack(alignment: .top) {
            GameDetailImageView(url: viewModel.gameDetail?.backgroundImage)
            
            if viewModel.isLoading {
                loadingView
            } else if let gameDetail = viewModel.gameDetail {
                gameDetailContent(gameDetail)
            }
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 220)
    }
    
    @ViewBuilder
    private func gameDetailContent(_ gameDetail: GameDetail) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            GameHeaderView(gameDetail: gameDetail)
            RatingView(gameDetail: gameDetail)
            GameDetailDescriptionView(gameDetail: gameDetail)
        }
        .padding(.top, 220)
    }
}

#Preview {
    GameDetailView(gameId: 3489)
}

