//
//  NetworkError.swift
//  MovieMate
//
//  Created by Yasir on 30/09/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case unknown
    case decodingError(Error)
    case imageCreationFailed
}
