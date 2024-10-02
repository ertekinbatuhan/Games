//
//  GameHeaderView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 26.09.2024.
//

import SwiftUI

struct GameHeaderView: View {
    let gameDetail: GameDetail
    
    var body: some View {
        HStack {
            
            Text(gameDetail.name ?? "Unknown Game")
                .font(.title)
                .bold()
                .padding(.top, 140)
            
            Spacer()
            
            if let released = gameDetail.released {
                HStack {
                    
                    Image(systemName: "calendar")
                        .foregroundColor(.white)
                    
                    Text(released.formatDate())
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(8)
                .background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.8), Color.orange.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(12)
                .shadow(radius: 4)
                .padding(.top, 140)
            }
        }
        .padding(.horizontal)
    }
    
    
}
