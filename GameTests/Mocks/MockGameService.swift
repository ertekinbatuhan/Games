//
//  MockGameService.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 28.09.2024.
//

@testable import Games

class MockGameService: GameServiceProtocol {
    var mockGames: [GameResult]?
    var mockGameDetail: GameDetail?
    var mockSearchResults: [GameResult]?
    var mockError: Error?
    
    func fetchGames(path: NetworkPath, completion: @escaping (Result<[GameResult], Error>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else if let games = mockGames {
            completion(.success(games))
        }
    }
    
    func fetchGameDetail(id: Int, completion: @escaping (Result<GameDetail, Error>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else if let gameDetail = mockGameDetail {
            completion(.success(gameDetail))
        }
    }
    
    func fetchGameSearch(page: Int, name: String, completion: @escaping (Result<[GameResult], Error>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else if let searchResults = mockSearchResults {
            completion(.success(searchResults))
        }
    }
}
