//
//  HomePresenter.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol {
    
    var view: HomeViewControllerProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchTrendingMovies()
    }
    
    func fetchBackDrop(for movie: Movie) {
        interactor?.fetchBackDrop(for: movie)
    }
    
    func fetchPoster(for movie: Movie) {
        interactor?.fetchPoster(for: movie)
    }
    
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func didFetchTrendingMovies(_ movies: [Movie]) {
        view?.displayTrendingMovies(movies)
    }
    
    func didFailToFetchTrendingMovies(_ error: NetworkError) {
        view?.displayErrorInFetchingTrendingMovies()
    }
    
    func didFetchBackDrop(_ backDrop: UIImage, for movie: Movie) {
        view?.displayBackDrop(backDrop, for: movie)
    }
    
    func didFailToFetchBackDrop(for movie: Movie, with error: Error) {
        view?.failedToFetchBackDrop(for: movie)
    }
    
    func didFetchPoster(_ poster: UIImage, for movie: Movie) {
        view?.displayPoster(poster, for: movie)
    }
    
    func didFailToFetchPoster(for movie: Movie, with error: Error) {
        view?.failedToFetchPoster(for: movie)
    }
}
