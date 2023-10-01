//
//  FetchPoster.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation
import UIKit

class FetchImage: UseCase<FetchImage.Request, FetchImage.Response, NetworkError> {
    
    public struct Request: BaseRequest {
        public var baseURL: APIBaseURL
        public var endPoint: APIEndpoint
        public var version: APIVersion?
        public var shouldAddAuthorization: Bool
        
        init(from path: String, ofWidth width: Int) {
            self.baseURL = .tmdbImageAPI
            self.endPoint = .image(path: path, width: width)
            self.shouldAddAuthorization = false
        }
    }
    
    public struct Response: BaseResponse {
        let image: UIImage
    }
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    override func run(request: Request, completion: @escaping (Result<Response, NetworkError>) -> Void) {
        networkManager.fetchImage(from: request, completion: { (result: Result<UIImage, NetworkError>) in
            switch result {
            case .success(let image):
                completion(.success(Response(image: image)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
