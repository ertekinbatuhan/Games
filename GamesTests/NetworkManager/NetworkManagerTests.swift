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
    
    func testRequestData_givenAPISuccess_whenFetchingGame_thenShowsGame() {
        // Given: When a successful response is received from the API
        let expectedGameResult = GameResult(id: 1, slug: "example-game", name: "Example Game", released: "2024-01-01", tba: false, backgroundImage: nil, rating: 9.5, ratingTop: 10, shortScreenshots: nil, genres: nil)
        let expectedGame = Game(count: 1, next: nil, previous: nil, results: [expectedGameResult], description: "Example description")
        let expectedData = try! JSONEncoder().encode(expectedGame)
        mockNetworkManager.result = .success(expectedData)
        
        // When: When fetching the game data
        let expectation = self.expectation(description: "Completion handler invoked")
        var receivedResult: Result<Game, Error>?
        
        mockNetworkManager.requestData(path: .games(page: 1), type: Game.self) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then: The received result should match the expected outcome
        waitForExpectations(timeout: 1, handler: nil)
        switch receivedResult {
        case .success(let game):
            XCTAssertEqual(game.results?.first?.name, "Example Game")
        case .failure:
            XCTFail("Expected success, but got failure")
        default:
            XCTFail("Expected success, but got nil")
        }
    }
    
    func testRequestData_givenAPIFailure_whenFetchingGame_thenShowsError() {
        // Given: When an error is received from the API
        mockNetworkManager.result = .failure(NetworkError.invalidResponse)
        
        // When: When attempting to fetch the game data
        let expectation = self.expectation(description: "Completion handler invoked")
        var receivedResult: Result<Game, Error>?
        
        mockNetworkManager.requestData(path: .games(page: 1), type: Game.self) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then: An error message should be expected
        waitForExpectations(timeout: 1, handler: nil)
        switch receivedResult {
        case .success:
            XCTFail("Expected failure, but got success")
        case .failure(let error):
            // Instead of checking for equality, check for the specific type
            if case NetworkError.invalidResponse = error {
                // Test passed, expected error was received
            } else {
                XCTFail("Expected invalidResponse error, but got \(error)")
            }
        default:
            XCTFail("Expected failure, but got nil")
        }
    }
}

