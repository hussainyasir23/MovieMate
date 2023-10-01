//
//  HomeInteractor.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation
import UIKit

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    
    private lazy var fetchTrendingMoviesUC: FetchTrendingMovies = {
        return FetchTrendingMovies(networkManager: NetworkManager.shared)
    }()
    
    private lazy var fetchImageUC: FetchImage = {
        return FetchImage(networkManager: NetworkManager.shared)
    }()
    
    func fetchTrendingMovies() {
        let request = FetchTrendingMovies.Request()
        fetchTrendingMoviesUC.execute(request: request, completion: { [weak self] (result: Result<FetchTrendingMovies.Response, NetworkError>) in
            switch result {
            case .success(let response):
                self?.presenter?.didFetchTrendingMovies(response.results)
            case .failure(let error):
                self?.presenter?.didFailToFetchTrendingMovies(error)
            }
        })
    }
    
    func fetchBackDrop(for movie: Movie) {
        guard let backropPath = movie.backdrop_path else {
            self.presenter?.didFailToFetchBackDrop(for: movie, with: NetworkError.badURL)
            return
        }
        let request = FetchImage.Request(from: backropPath, ofWidth: 1280)
        fetchImageUC.execute(request: request, completion: { [weak self] (result: Result<FetchImage.Response, NetworkError>) in
            switch result {
            case .success(let response):
                self?.presenter?.didFetchBackDrop(response.image, for: movie)
            case .failure(let error):
                self?.presenter?.didFailToFetchBackDrop(for: movie, with: error)
            }
        })
    }
    
    func fetchPoster(for movie: Movie) {
        guard let posterPath = movie.poster_path else {
            self.presenter?.didFailToFetchPoster(for: movie, with: NetworkError.badURL)
            return
        }
        let request = FetchImage.Request(from: posterPath, ofWidth: 500)
        fetchImageUC.execute(request: request, completion: { [weak self] (result: Result<FetchImage.Response, NetworkError>) in
            switch result {
            case .success(let response):
                self?.presenter?.didFetchPoster(response.image, for: movie)
            case .failure(let error):
                self?.presenter?.didFailToFetchPoster(for: movie, with: error)
            }
        })
    }
}
