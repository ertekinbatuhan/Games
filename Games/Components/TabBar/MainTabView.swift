//
//  MainTabView.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 26.09.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            GamesView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }

            FavoriteGamesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
    }
}
