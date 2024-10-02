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
        VStack(alignment: .leading, spacing: 5) {
            Text(game.name ?? "Unknown Game")
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
                .padding(.horizontal, 8)
            
            if let releasedDate = game.released {
                Text("Released: \(releasedDate.formatDate())")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
            } else {
                Text("Released: Unknown")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
            }
            
            HStack(spacing: 2) {
                ForEach(0..<5) { index in
                    Image(systemName: index < Int(game.rating?.rounded() ?? 0) ? "star.fill" : "star")
                        .foregroundColor(index < Int(game.rating?.rounded() ?? 0) ? .yellow : .gray)
                }
            }
            .padding(.horizontal, 8)
        }
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.6))
        .cornerRadius(12)
        .padding(.horizontal, 2)
    }
}
