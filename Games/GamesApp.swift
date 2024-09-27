//
//  GamesApp.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 23.09.2024.
//

import SwiftUI

@main
struct GamesApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }.modelContainer(for : [FavoriteGame.self])
    }
}
