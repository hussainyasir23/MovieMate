//
//  Movie.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation

struct Movie: Codable {

    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let mediaType: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct MovieDate: Codable {
    let maximum: String
    let minimum: String
}
