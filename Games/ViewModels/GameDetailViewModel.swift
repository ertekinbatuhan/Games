//
//  GameDetailViewModel.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 25.09.2024.
//

import Foundation

// MARK: - GameDetailViewModelProtocol
protocol GameDetailViewModelProtocol {
    func loadGameDetail(id: Int) async
}

// MARK: - GameDetailViewModel
@MainActor
final class GameDetailViewModel: ObservableObject, GameDetailViewModelProtocol {
    @Published var gameDetail: GameDetail?
    @Published var isLoading: Bool = false
    
    private let gameService: GameServiceProtocol
    
    // MARK: - Initializer
    init(gameService: GameServiceProtocol = GameService()) {
        self.gameService = gameService
    }
    
    // MARK: - Fetch Game Detail Function
    /// Fetches game detail for the given ID.
    /// - Parameter id: The ID of the game to fetch details for.
    func loadGameDetail(id: Int) async {
        // MARK: - Prevent Concurrent Loading
        guard !isLoading else { return }
        
        isLoading = true
        
        do {
            let gameDetail = try await gameService.fetchGameDetail(id: id)
            self.gameDetail = gameDetail
            self.isLoading = false
        } catch {
            print(error.localizedDescription)
            self.isLoading = false
        }
    }
}
