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
    var mockGameService: MockGameService!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        gameService = GameService(networkManager: mockNetworkManager)
        mockGameService = MockGameService()
    }
    
    override func tearDown() {
        gameService = nil
        mockNetworkManager = nil
        mockGameService = nil
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
    
    func testFetchGameDetail_givenMockSuccess_whenFetchingGameDetail_thenReturnsGameDetail() {
        // Given: Mock game detail
        let expectedGameDetail = GameDetail(
            id: 1,
            name: "Example Game",
            description: "An example game description.",
            metacritic: 85,
            released: "2024-01-01",
            backgroundImage: "https://example.com/image.jpg",
            website: "https://example.com",
            rating: 9.5,
            added: 100,
            playtime: 20,
            redditURL: "https://reddit.com/example",
            redditName: "example_reddit",
            ratingsCount: 500,
            metacriticURL: "https://metacritic.com/example",
            gameSeriesCount: 3
        )
        
        mockGameService.mockGameDetail = expectedGameDetail
        
        // When: Fetching game detail
        let expectation = self.expectation(description: "Completion handler invoked")
        var receivedResult: Result<GameDetail, Error>?
        
        mockGameService.fetchGameDetail(id: 1) { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then: Expected game detail should be returned
        waitForExpectations(timeout: 1, handler: nil)
        switch receivedResult {
        case .success(let gameDetail):
            XCTAssertEqual(gameDetail.name, "Example Game")
            XCTAssertEqual(gameDetail.metacritic, 85)
            XCTAssertEqual(gameDetail.backgroundImage, "https://example.com/image.jpg")
            XCTAssertEqual(gameDetail.rating, 9.5)
            XCTAssertEqual(gameDetail.added, 100)
        case .failure:
            XCTFail("Expected success, but got failure")
        case .none:
            break
        }
    }
    
    func testFetchGameSearch_givenMockSuccess_whenFetchingGameSearch_thenReturnsSearchResults() {
        // Given: Mock search result
        let expectedGameResult = GameResult(id: 1, slug: "example-game", name: "Example Game", released: "2024-01-01", tba: false, backgroundImage: nil, rating: 9.5, ratingTop: 10, shortScreenshots: nil, genres: nil)
        mockGameService.mockSearchResults = [expectedGameResult]
        
        // When: Searching for game
        let expectation = self.expectation(description: "Completion handler invoked")
        var receivedResult: Result<[GameResult], Error>?
        
        mockGameService.fetchGameSearch(page: 1, name: "Example") { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then: Expected search results should be returned
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
    
    func testFetchGameSearch_givenMockFailure_whenFetchingGameSearch_thenShowsError() {
        // Given: Mock error condition
        mockGameService.mockError = NetworkError.invalidResponse
        
        // When: Searching for game
        let expectation = self.expectation(description: "Completion handler invoked")
        var receivedResult: Result<[GameResult], Error>?
        
        mockGameService.fetchGameSearch(page: 1, name: "Example") { result in
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
