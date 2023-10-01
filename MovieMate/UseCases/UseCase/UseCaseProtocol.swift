//
//  UseCaseProtocol.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation

protocol UseCaseProtocol {
    associatedtype RequestType: BaseRequest
    associatedtype ResponseType: BaseResponse
    associatedtype ErrorType: Error
    
    func execute(request: RequestType, completion: @escaping (Result<ResponseType, ErrorType>) -> Void)
}
