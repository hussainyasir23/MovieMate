//
//  HomeViewControllerProtocol.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation
import UIKit

protocol HomeViewControllerProtocol {
    
    var presenter: HomePresenterProtocol? { get set }
    
    func displayTrendingMovies(_ trendingMovies: [Movie])
    func failedToFetchTrendingMovies()
    
    func displayBackDrop(_ backDrop: UIImage, for movie: Movie)
    func failedToFetchBackDrop(for movie: Movie)
    
    func displayNowPlayingMovies(_ nowPlayingMovies: [Movie])
    func failedToFetchNowPlayingMovies()
    
    func displayPoster(_ poster: UIImage, for movie: Movie)
    func failedToFetchPoster(for movie: Movie)
}
