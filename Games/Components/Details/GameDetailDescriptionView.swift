//
//  DescriptionView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 26.09.2024.
//

import SwiftUI

struct GameDetailDescriptionView: View {
    let gameDetail: GameDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Description")
                    .font(.headline)
                    .padding(.top, 5)
                
                Image(systemName: "info.circle")
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            .padding(.horizontal)
            
            Text(gameDetail.description?.cleanedDescription() ?? "No Description Available")
                .font(.body)
                .padding(.horizontal)
                .padding(.bottom)
        }
    }
}
