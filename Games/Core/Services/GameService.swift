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
            switch result {
            case .success(let game): 
                completion(.success(game.results ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Game Detail fetching function
     func fetchGameDetail(id: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
         networkManager.requestData(path: NetworkPath.gameDetail(id: id), type: GameDetail.self) { result in
             switch result {
             case .success(let gameDetail):
                 completion(.success(gameDetail))
             case .failure(let error):
                 completion(.failure(error)) 
             }
         }
     }
   
}
