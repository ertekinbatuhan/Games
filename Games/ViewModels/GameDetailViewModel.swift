//
//  GameDetailViewModel.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 25.09.2024.
//

import Foundation

// MARK: - GameDetailViewModelProtocol
protocol GameDetailViewModelProtocol {
    func loadGameDetail(id: Int)
    var gameDetail: GameDetail? { get }
    var isLoading: Bool { get }
}

// MARK: - GameDetailViewModel
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
    func loadGameDetail(id: Int) {
        // MARK: - Prevent Concurrent Loading
        guard !isLoading else { return }
        
        isLoading = true
        gameService.fetchGameDetail(id: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let gameDetail):
                    self?.gameDetail = gameDetail
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
