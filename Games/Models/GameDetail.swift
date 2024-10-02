//
//  GameDetail.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 25.09.2024.
//

import Foundation

// MARK: - GameDetail
struct GameDetail: Codable {
    let id: Int?
    let name, description: String?
    let metacritic: Int?
    let released: String?
    let backgroundImage: String?
    let website: String?
    let rating: Double?
    let added: Int?
    let playtime: Int?
    let redditURL: String?
    let redditName: String?
    let ratingsCount: Int?
    let metacriticURL: String?
    let gameSeriesCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, metacritic, released
        case backgroundImage = "background_image"
        case website, rating, added, playtime
        case redditURL = "reddit_url"
        case redditName = "reddit_name"
        case ratingsCount = "ratings_count"
        case metacriticURL = "metacritic_url"
        case gameSeriesCount = "game_series_count"
    }
}
