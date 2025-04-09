//
//  MockGameService.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 28.09.2024.
//

@testable import Games
import Foundation
// MARK: - Mock Game Service
final class MockGameService: GameServiceProtocol {
    var mockGames: [GameResult]?
    var mockGameDetail: GameDetail?
    var mockSearchResults: [GameResult]?
    var mockError: Error?
    
    func fetchGames(path: NetworkPath) async throws -> [GameResult] {
        if let error = mockError {
            throw error
        } else if let games = mockGames {
            return games
        }
        return []
    }
    
    func fetchGameDetail(id: Int) async throws -> GameDetail {
        if let error = mockError {
            throw error
        } else if let gameDetail = mockGameDetail {
            return gameDetail
        }
        throw NSError(domain: "MockService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Game detail not found"])
    }
    
    func fetchGameSearch(page: Int, name: String) async throws -> [GameResult] {
        if let error = mockError {
            throw error
        } else if let searchResults = mockSearchResults {
            return searchResults
        }
        return []
    }
}
