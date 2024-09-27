//
//  FavoriteGameInfoView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 27.09.2024.
//

import SwiftUI

struct FavoriteGameInfoView: View {
    var game: FavoriteGame
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(game.name ?? "Unknown Game")
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
                .padding(.horizontal, 10)
            
            Text("Released: \(game.released ?? "Unknown")")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
            
            HStack(spacing: 2) {
                ForEach(0..<5) { index in
                    Image(systemName: index < Int(game.rating?.rounded() ?? 0) ? "star.fill" : "star")
                        .foregroundColor(index < Int(game.rating?.rounded() ?? 0) ? .yellow : .gray)
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.6))
        .cornerRadius(15)
        .padding(.horizontal, 10)
    }
}
