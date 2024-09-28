//
//  GameServiceTests.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 28.09.2024.
//

import XCTest
@testable import Games

final class GameServiceTests: XCTestCase {
    
    var gameService: GameService!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        gameService = GameService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        gameService = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testFetchGames_givenAPISuccess_whenFetchingGames_thenReturnsGames() {
        // Given: A successful response from the API
        let expectedGameResult = GameResult(id: 1, slug: "example-game", name: "Example Game", released: "2024-01-01", tba: false, backgroundImage: nil, rating: 9.5, ratingTop: 10, shortScreenshots: nil, genres: nil)
        let expectedGame = Game(count: 1, next: nil, previous: nil, results: [expectedGameResult], description: "Example description")
        let expectedData = try! JSONEncoder().encode(expectedGame)
        mockNetworkManager.result = .success(expectedData)
        
        // When: Fetching games
        let expectation = self.expectation(description: "Completion handler invoked")
        var receivedResult: Result<[GameResult], Error>?
        
        gameService.fetchGames(path: .games(page: 1)) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then: The expected games should be returned
        waitForExpectations(timeout: 1, handler: nil)
        switch receivedResult {
        case .success(let games):
            XCTAssertEqual(games.first?.name, "Example Game")
        case .failure:
            XCTFail("Expected success, but got failure")
        case .none:
            break
        }
    }
    
    func testFetchGames_givenAPIFailure_whenFetchingGames_thenShowsError() {
        // Given: An error response from the API
        mockNetworkManager.result = .failure(NetworkError.invalidResponse)
        
        // When: Fetching games
        let expectation = self.expectation(description: "Completion handler invoked")
        var receivedResult: Result<[GameResult], Error>?
        
        gameService.fetchGames(path: .games(page: 1)) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then: An error should be returned
        waitForExpectations(timeout: 1, handler: nil)
        switch receivedResult {
        case .success:
            XCTFail("Expected failure, but got success")
        case .failure(let error):
            if case NetworkError.invalidResponse = error {
                // Test passed
            } else {
                XCTFail("Expected invalidResponse error, but got \(error)")
            }
        case .none:
            break
        }
    }
}
