//
//  APIEndpoints.swift
//  MovieMate
//
//  Created by Yasir on 30/09/23.
//

import Foundation

public enum APIEndpoint {
    case trendingMovies
    case nowPlayingMovies
    case popularMovies
    case topRatedMovies
    case upcomingMovies
    
    case image(path: String, width: Int)
    case movieDetails(id: Int)
    
    var urlString: String {
        switch self {
        case .trendingMovies:
            return "/trending/movie/week"
        case .nowPlayingMovies:
            return "/movie/now_playing"
        case .popularMovies:
            return "/movie/popular"
        case .topRatedMovies:
            return "/movie/top_rated"
        case .upcomingMovies:
            return "/movie/upcoming"
        case .image(let path, let width):
            return "/t/p/w\(width)\(path)"
        case .movieDetails(let id):
            return "/movie/\(id)"
        }
    }
}
