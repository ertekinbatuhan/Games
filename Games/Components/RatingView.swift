//
//  RatingView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 26.09.2024.
//

import SwiftUI

struct RatingView: View {
    let gameDetail: GameDetail
    let colorScheme: ColorScheme

    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: index < Int(gameDetail.rating?.rounded() ?? 0) ? "star.fill" : "star")
                    .foregroundColor(index < Int(gameDetail.rating?.rounded() ?? 0) ? .yellow : .gray)
            }
            Text("(\(String(format: "%.1f", gameDetail.rating ?? 0)))")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()
            
            if let metacriticScore = gameDetail.metacritic {
                Text("Metacritic: \(metacriticScore)")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding(6)
                    .background(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
