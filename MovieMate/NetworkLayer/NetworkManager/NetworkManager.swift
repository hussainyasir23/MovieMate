//
//  NetworkManager.swift
//  MovieMate
//
//  Created by Yasir on 30/09/23.
//

import Foundation
import UIKit

class NetworkManager: NetworkManagerProtocol {
    
    
    
    private init() {}
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(from fetchRequest: BaseRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        var urlString: String = fetchRequest.baseURL.urlString
        if let version = fetchRequest.version?.versionString {
            urlString += version
        }
        urlString += fetchRequest.endPoint.urlString
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if fetchRequest.shouldAddAuthorization {
            request.addValue("Bearer \(authHeaderToken)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodeError {
                completion(.failure(.decodingError(decodeError)))
            }
            
        }.resume()
    }
    
    func fetchImage(from fetchRequest: BaseRequest, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        var urlString: String = fetchRequest.baseURL.urlString
        if let version = fetchRequest.version?.versionString {
            urlString += version
        }
        urlString += fetchRequest.endPoint.urlString
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if fetchRequest.shouldAddAuthorization {
            request.addValue("Bearer \(authHeaderToken)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.imageCreationFailed))
                return
            }
            
            completion(.success(image))
            
        }.resume()
    }
}
