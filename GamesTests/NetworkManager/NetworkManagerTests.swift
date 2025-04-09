//
//  GamesUnitTests.swift
//  GamesUnitTests
//
//  Created by Batuhan Berk Ertekin on 28.09.2024.
//

import XCTest
@testable import Games

final class NetworkManagerTests: XCTestCase {
    
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testRequestData_givenAPISuccess_whenFetchingGame_thenShowsGame() async throws {
        // Given: When a successful response is received from the API
        let expectedGameResult = GameResult(id: 1, slug: "example-game", name: "Example Game", released: "2024-01-01", tba: false, backgroundImage: nil, rating: 9.5, ratingTop: 10, shortScreenshots: nil, genres: nil)
        let expectedGame = Game(count: 1, next: nil, previous: nil, results: [expectedGameResult], description: "Example description")
        let expectedData = try! JSONEncoder().encode(expectedGame)
        mockNetworkManager.result = .success(expectedData)
        
        // When: When fetching the game data
        let game = try await mockNetworkManager.requestData(path: .games(page: 1), type: Game.self)
        
        // Then: The received result should match the expected outcome
        XCTAssertEqual(game.results?.first?.name, "Example Game")
    }
    
    func testRequestData_givenAPIFailure_whenFetchingGame_thenShowsError() async {
        // Given: When an error is received from the API
        mockNetworkManager.result = .failure(NetworkError.invalidResponse)
        
        // When & Then: When attempting to fetch the game data, an error should be thrown
        do {
            _ = try await mockNetworkManager.requestData(path: .games(page: 1), type: Game.self)
            XCTFail("Expected error to be thrown")
        } catch {
            // Check if the error is the expected one
            if case NetworkError.invalidResponse = error {
                // Test passed, expected error was received
            } else {
                XCTFail("Expected invalidResponse error, but got \(error)")
            }
        }
    }
}

