//
//  BackgroundImageView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 26.09.2024.
//

import SwiftUI

struct GameDetailImageView: View {
    let url: String?
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { image in
            image
                .resizable()
                .ignoresSafeArea(edges: .top)
                .frame(height: 350)
        } placeholder: {
            ProgressView()
        }
    }
}
