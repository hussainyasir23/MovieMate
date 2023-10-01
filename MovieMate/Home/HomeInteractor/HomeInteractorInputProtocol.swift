//
//  HomeInteractorInputProtocol.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation

protocol HomeInteractorInputProtocol {
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    func fetchTrendingMovies()
    func fetchBackDrop(for movie: Movie)
    func fetchPoster(for movie: Movie)
}
