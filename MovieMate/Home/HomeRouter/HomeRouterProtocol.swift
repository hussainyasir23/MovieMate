//
//  HomeRouterProtocol.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation

protocol HomeRouterProtocol {
    static func getHomeModule() -> HomeViewController
    func presentMovieDetailsScreen(from view: HomeViewControllerProtocol, forMovie movie: Movie)
}
