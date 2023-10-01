//
//  HomeInteractorOutputProtocol.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation
import UIKit

protocol HomeInteractorOutputProtocol: AnyObject {
    
    func didFetchTrendingMovies(_ movies: [Movie])
    func didFailToFetchTrendingMovies(_ error: NetworkError)
    
    func didFetchBackDrop(_ backDrop: UIImage, for movie: Movie)
    func didFailToFetchBackDrop(for movie: Movie, with error: Error)
    
    func didFetchPoster(_ poster: UIImage, for movie: Movie)
    func didFailToFetchPoster(for movie: Movie, with error: Error)
}
