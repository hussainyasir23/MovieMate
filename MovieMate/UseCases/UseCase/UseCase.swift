//
//  UseCase.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation

public protocol BaseRequest {
    var baseURL: APIBaseURL { get }
    var endPoint: APIEndpoint { get }
    var version: APIVersion? { get }
    var shouldAddAuthorization: Bool { get }
}

public protocol BaseResponse {
    
}

class UseCase<RequestType: BaseRequest, ResponseType: BaseResponse, ErrorType: Error>: UseCaseProtocol {
    
    private let useCaseQueue = DispatchQueue(label: "com.hussainyasir23.MovieMate.UseCaseQueue", attributes: .concurrent)
    
    final func execute(request: RequestType, completion: @escaping (Result<ResponseType, ErrorType>) -> Void) {
        useCaseQueue.async { [weak self] in
            self?.run(request: request, completion: completion)
        }
    }
    
    internal func run(request: RequestType, completion: @escaping (Result<ResponseType, ErrorType>) -> Void) {
        
    }
}
