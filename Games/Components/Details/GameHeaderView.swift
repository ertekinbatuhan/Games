//
//  GameHeaderView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 26.09.2024.
//

import SwiftUI

struct GameHeaderView: View {
    let gameDetail: GameDetail
    let colorScheme: ColorScheme

    var body: some View {
        HStack {
            Text(gameDetail.name ?? "Unknown Game")
                .font(.title)
                .bold()
                .padding(.top, 140)
            
            Spacer()
            
            if let released = gameDetail.released {
                Text("Released: \(released)")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding(6)
                    .background(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10)
                    .padding(.top, 140)
            }
        }
        .padding(.horizontal)
    }
}
