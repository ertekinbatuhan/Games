//
//  FavoriteGameViewModel.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 27.09.2024.
//

import SwiftUI
import SwiftData

// MARK: - FavoriteGameViewModelProtocol

protocol FavoriteGameViewModelProtocol {
    func addFavoriteGame(id: Int?, name: String?, released: String?, backgroundImage: String?, rating: Double?, context: ModelContext)
    func deleteFavoriteGame(_ game: FavoriteGame, context: ModelContext)
    func searchFavoriteGames(with keyword: String, from games: [FavoriteGame])
}

// MARK: - FavoriteGameViewModel

final class FavoriteGameViewModel: ObservableObject, FavoriteGameViewModelProtocol {
    
    @Published var filteredGames: [FavoriteGame] = []
    
    // MARK: - Add Favorite Game
    
    func addFavoriteGame(id: Int?, name: String? = nil, released: String? = nil, backgroundImage: String? = nil, rating: Double? = nil, context: ModelContext) {
        
        let newFavoriteGame = FavoriteGame(id: id, name: name, released: released, backgroundImage: backgroundImage, rating: rating)
        
        context.insert(newFavoriteGame)
        
        do {
            try context.save()
        } catch {
            print("Error saving favorite game: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Delete Favorite Game
    
    func deleteFavoriteGame(_ game: FavoriteGame, context: ModelContext) {
        context.delete(game)
        
        withAnimation {
            do {
                try context.save()
            } catch {
                print("Error deleting favorite game: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Search Favorite Game
    
    func searchFavoriteGames(with keyword: String, from games: [FavoriteGame]) {
        if keyword.isEmpty {
            filteredGames = games
        } else {
            filteredGames = games.filter { game in
                game.name?.localizedCaseInsensitiveContains(keyword) ?? false
            }
        }
    }
}
