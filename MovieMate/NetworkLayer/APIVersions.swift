//
//  APIVersions.swift
//  MovieMate
//
//  Created by Yasir on 30/09/23.
//

import Foundation

public enum APIVersion {
    case v3
    var versionString: String {
        switch self {
        case .v3:
            return "/3"
        }
    }
}
