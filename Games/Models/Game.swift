//
//  Games.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 24.09.2024.
//

import Foundation

// MARK: - Game
struct Game: Codable , Equatable{
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameResult]?
    let description: String?
}

// MARK: - Result
struct GameResult: Codable , Identifiable, Equatable{
    let id: Int?
    let slug, name, released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let shortScreenshots: [ShortScreenshot]?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba,genres
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case shortScreenshots = "short_screenshots"
    }
    
    static func == (lhs: GameResult, rhs: GameResult) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int?
    let image: String?
}

