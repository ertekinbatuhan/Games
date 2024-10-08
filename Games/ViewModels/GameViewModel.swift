//
//  GameViewModel.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 24.09.2024.
//

import Foundation

// MARK: - GameViewModelProtocol
protocol GameViewModelProtocol {
    func loadGames(page: Int)
    func searchGames(name: String, page: Int) 
}

// MARK: - GameViewModel
/// ViewModel responsible for managing game data
final class GameViewModel: ObservableObject, GameViewModelProtocol {
    
    // MARK: - Published Properties
    @Published var games: [GameResult] = []
    @Published var isLoading = false
    
    // MARK: - Internal Properties
    var currentPage: Int = 1
    private let gameService: GameServiceProtocol
    
    // MARK: - Initializer
    init(gameService: GameServiceProtocol = GameService()) {
        self.gameService = gameService
    }
    
    // MARK: - Load Games Function
    /// Fetches games from the given page using the game service.
    /// Prevents multiple requests from being made at the same time.
    /// - Parameter page: The page number to load games from.
    func loadGames(page: Int) {
        
        // MARK: - Prevent Concurrent Loading
        guard !isLoading else { return }
        
        isLoading = true
        
        // MARK: - Fetch Games
        gameService.fetchGames(path: NetworkPath.games(page: page)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let gameResults):
                    self?.games.append(contentsOf: gameResults)
                    self?.currentPage = page
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.isLoading = false
            }
        }
    }
    
    // MARK: - Search Games Function
    /// Searches for games using the given name and page number.
    /// - Parameters:
    ///   - name: The name of the game to search for.
    ///   - page: The page number for pagination.
    func searchGames(name: String, page: Int) {
        
        // MARK: - Prevent Concurrent Loading
        guard !isLoading else { return }
        
        isLoading = true
        
        gameService.fetchGameSearch(page: page, name: name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let gameResults):
                    self?.games = gameResults
                    self?.currentPage = page
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.isLoading = false
            }
        }
    }
}
