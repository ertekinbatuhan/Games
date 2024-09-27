//
//  FavoriteGames.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 27.09.2024.
//

import SwiftUI
import SwiftData

@Model
class FavoriteGame {
    var id: Int?
    var name: String?
    var released: String?
    var backgroundImage: String?
    var rating: Double?
    init(id: Int? = nil, name: String? = nil, released: String? = nil, backgroundImage: String? = nil, rating: Double? = nil) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
       
    }
}
