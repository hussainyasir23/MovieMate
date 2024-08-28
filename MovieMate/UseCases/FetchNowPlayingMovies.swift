//
//  FetchNowPlayingMovies.swift
//  MovieMate
//
//  Created by Yasir on 02/10/23.
//

import Foundation

class FetchNowPlayingMovies: UseCase<FetchNowPlayingMovies.Request, FetchNowPlayingMovies.Response, NetworkError> {

    public struct Request: BaseRequest {
        public var baseURL: APIBaseURL
        public var endPoint: APIEndpoint
        public var version: APIVersion?
        public var shouldAddAuthorization: Bool

        init() {
            self.baseURL = .tmdbAPI
            self.endPoint = .nowPlayingMovies
            self.version = .v3
            self.shouldAddAuthorization = true
        }
    }

    public struct Response: BaseResponse, Decodable {
        let dates: MovieDate
        let page: Int
        let results: [Movie]
    }

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    override internal func run(request: Request, completion: @escaping (Result<Response, NetworkError>) -> Void) {
        networkManager.fetchData(from: request, completion: { (result: Result<Response, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
