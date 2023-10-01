//
//  APIBaseURL.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation

public enum APIBaseURL {
    case tmdbAPI
    case tmdbImageAPI
    
    var urlString: String {
        switch self {
        case .tmdbAPI:
            return "https://api.themoviedb.org"
        case .tmdbImageAPI:
            return "https://image.tmdb.org"
        }
    }
}
