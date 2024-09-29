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
            ZStack(alignment: .top) {
                GameDetailImageView(url: viewModel.gameDetail?.backgroundImage)
                
                VStack(alignment: .leading, spacing: 10) {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let gameDetail = viewModel.gameDetail {
                        GameHeaderView(gameDetail: gameDetail)
                        RatingView(gameDetail: gameDetail)
                        GameDetailDescriptionView(gameDetail: gameDetail)
                    }
                }
                .padding(.top, 220)
            }
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            viewModel.loadGameDetail(id: gameId)
        }
    }
}

#Preview {
    GameDetailView(gameId: 3489)
}

