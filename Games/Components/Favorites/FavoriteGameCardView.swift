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
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: game.backgroundImage ?? "")) { image in
                switch image {
                case .success(let loadedImage):
                    loadedImage
                        .resizable()
                        .frame(width: 400 ,height: 200)
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
            
            Image(systemName: "heart.fill")
                .font(.system(size: 24))
                .foregroundColor(.red)
                .padding(10)
                .background(Color.white.opacity(0.8))
                .cornerRadius(30)
                .padding([.top, .trailing], 10)
            
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
