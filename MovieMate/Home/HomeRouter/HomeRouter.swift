//
//  HomeRouter.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation

class HomeRouter: HomeRouterProtocol {
    
    static func getHomeModule() -> HomeViewController {
        let view = HomeViewController()
        var presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        var interactor: HomeInteractorInputProtocol = HomeInteractor()
        let router: HomeRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func presentMovieDetailsScreen(from view: HomeViewControllerProtocol, forMovie movie: Movie) {
        
    }
}
