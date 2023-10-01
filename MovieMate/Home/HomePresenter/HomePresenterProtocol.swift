//
//  HomePresenterProtocol.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation

protocol HomePresenterProtocol {
    
    var view: HomeViewControllerProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
    func fetchBackDrop(for movie: Movie)
    func fetchPoster(for movie: Movie)
}
