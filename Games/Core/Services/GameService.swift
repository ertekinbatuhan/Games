//
//  GameService.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 24.09.2024.
//

import Foundation

//MARK: - GameServiceProtocol
protocol GameServiceProtocol {
    func fetchGames(path: NetworkPath) async throws -> [GameResult]
    func fetchGameDetail(id: Int) async throws -> GameDetail
    func fetchGameSearch(page: Int, name: String) async throws -> [GameResult]
}

// MARK: - GameService
final class GameService: GameServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // General data fetching function
    func fetchGames(path: NetworkPath) async throws -> [GameResult] {
        let game = try await networkManager.requestData(path: path, type: Game.self)
        return game.results ?? []
    }
    
    // Game Detail fetching function
    func fetchGameDetail(id: Int) async throws -> GameDetail {
        return try await networkManager.requestData(path: NetworkPath.gameDetail(id: id), type: GameDetail.self)
    }
    
    // Game Search fetching function
    func fetchGameSearch(page: Int, name: String) async throws -> [GameResult] {
        let game = try await networkManager.requestData(path: NetworkPath.gameSearch(page: page, name: name), type: Game.self)
        return game.results ?? []
    }
}
