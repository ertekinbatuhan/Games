//
//  RatingView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 26.09.2024.
//

import SwiftUI

struct RatingView: View {
    let gameDetail: GameDetail
    
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
                HStack {
                    Image("metascore")
                        .resizable()
                        .frame(width: 32, height: 32)
                    
                    Text("\(metacriticScore)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.8), Color.orange.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
