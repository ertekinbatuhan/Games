//
//  GameService.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 24.09.2024.
//

import Foundation

//MARK: - GameServiceProtocol
protocol GameServiceProtocol {
    func fetchGames(path: NetworkPath, completion: @escaping (Result<[GameResult], Error>) -> Void)
    func fetchGameDetail(id: Int, completion: @escaping (Result<GameDetail, Error>) -> Void)
    func fetchGameSearch(page: Int, name: String, completion: @escaping (Result<[GameResult], Error>) -> Void)
}

// MARK: - GameService
final class GameService: GameServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    // General data fetching function
    func fetchGames(path: NetworkPath, completion: @escaping (Result<[GameResult], Error>) -> Void) {
        networkManager.requestData(path: path, type: Game.self) { result in
            completion(result.map { $0.results ?? [] })
        }
    }
    // Game Detail fetching function
    func fetchGameDetail(id: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
        networkManager.requestData(path: NetworkPath.gameDetail(id: id), type: GameDetail.self) { result in
            completion(result)
        }
    }
    // Game Search fetching function
    func fetchGameSearch(page: Int, name: String, completion: @escaping (Result<[GameResult], Error>) -> Void) {
        networkManager.requestData(path: NetworkPath.gameSearch(page: page, name: name), type: Game.self) { result in
            completion(result.map { $0.results ?? [] })
        }
    }
}
