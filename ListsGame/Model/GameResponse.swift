//
//  gameModel.swift
//  ListsGame
//
//  Created by irfan wahendra on 26/02/25.
//

import Foundation

struct GameResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [GameResult]
}

struct GameResult: Codable {
    let id: Int
    let slug: String
    let name: String
    let released: String?
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Double
    let ratings: [Rating]?
    let ratingsCount: Int
    let reviewsTextCount: Int
    let added: Int?
    let addedByStatus: AddedByStatus
    let metacritic: Int?
    let playtime: Int
    let suggestionsCount: Int
    let updated: String
    let esrbRating: EsrbRating
    let platforms: [Platform]
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic
        case playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case esrbRating = "esrb_rating"
        case platforms
    }
}

struct Rating: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

struct AddedByStatus: Codable {
    let yet: Int?
    let owned: Int?
    let beaten: Int?
    let toplay: Int?
    let dropped: Int?
    let playing: Int?
    
    init(yet: Int? = nil, owned: Int? = nil, beaten: Int? = nil, 
         toplay: Int? = nil, dropped: Int? = nil, playing: Int? = nil) {
        self.yet = yet
        self.owned = owned
        self.beaten = beaten
        self.toplay = toplay
        self.dropped = dropped
        self.playing = playing
    }
}

struct EsrbRating: Codable {
    let id: Int
    let slug: String
    let name: String
}

struct Platform: Codable {
    let platform: PlatformInfo
    let releasedAt: String
    let requirements: Requirements?
    
    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirements
    }
}

struct PlatformInfo: Codable {
    let id: Int
    let slug: String
    let name: String
}

struct Requirements: Codable {
    let minimum: String?
    let recommended: String?
}
