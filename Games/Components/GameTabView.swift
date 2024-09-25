//
//  GameTabView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 25.09.2024.
//

import SwiftUI

struct GameTabView: View {
    let games: [GameResult]
    @Binding var currentPage: Int
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(games) { game in
                ZStack(alignment: .topLeading) {
                    if let imageUrl = game.backgroundImage {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .cornerRadius(12)
                                .padding()
                        } placeholder: {
                            ProgressView()
                                .frame(height: 200)
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(12)
                            .foregroundColor(.gray)
                    }
                    
                    Text(game.name ?? "Unknown Game")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(10)
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 20)
                        .padding(.top, 20)
                }
                .tag(game.id ?? -1)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 200)
    }
}
