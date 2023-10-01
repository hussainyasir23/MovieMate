//
//  NetworkManagerProtocol.swift
//  MovieMate
//
//  Created by Yasir on 01/10/23.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(from fetchRequest: BaseRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
    func fetchImage(from fetchRequest: BaseRequest, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}
