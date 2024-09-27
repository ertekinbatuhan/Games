//
//  FavoriteGameCardView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 27.09.2024.
//

import SwiftUI

struct FavoriteGameCardView: View {
    @State private var showDeleteConfirmation = false
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var favoriteGameViewModel: FavoriteGameViewModel
    var game: FavoriteGame
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: game.backgroundImage ?? "")) { image in
                switch image {
                case .success(let loadedImage):
                    loadedImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .cornerRadius(15)
                        .onLongPressGesture {
                            showDeleteConfirmation = true
                        }
                default:
                    ProgressView()
                        .frame(width: 150, height: 250)
                }
            }
            .cornerRadius(15)
            .shadow(radius: 4)
            
            VStack {
                Spacer()
                
                FavoriteGameInfoView(game: game)
                    .padding(.bottom, 10)
            }
        }
        .frame(width: 350)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(
                title: Text("Delete Favorite Game"),
                message: Text("Are you sure you want to delete \(game.name ?? "this game")?"),
                primaryButton: .destructive(Text("Delete")) {
                    favoriteGameViewModel.deleteFavoriteGame(game, context: modelContext)
                },
                secondaryButton: .cancel()
            )
        }
    }
}
