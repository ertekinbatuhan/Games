//
//  GameRowView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 25.09.2024.
//

import SwiftUI

struct GameRowView: View {
    let game: GameResult
    
    var body: some View {
        HStack {
            if let imageUrl = game.backgroundImage {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 100)
                        .cornerRadius(5)
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading) {
                Text(game.name ?? "Unknown Game")
                    .font(.headline)
        
                HStack {
                    if let genres = game.genres {
                        let displayedGenres = genres.prefix(2)
                        ForEach(displayedGenres, id: \.id) { genre in
                            Text(genre.name ?? "Unknown Genre")
                                .font(.subheadline)
                                .padding(5)
                                .background(Color.blue.opacity(0.9))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding(.trailing, 5)
                        }
                    } else {
                        Text("No Categories Available")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 5)
            }
            .padding(.leading, 10)
        }
    }
}
