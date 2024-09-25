//
//  NetworkPath.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 24.09.2024.
//

import Foundation

// MARK: - NetworkPathProtocol
protocol NetworkPathProtocol {
    var value: String { get }
}

// MARK: - API endpoints enumeration
enum NetworkPath: NetworkPathProtocol {
    case games(page: Int)
    case gameDetail(id: Int)

    var value: String {
        switch self {
        case .games(let page):
            return "/games?key=\(APIConstant.apiKey)&page=\(page)"
        case .gameDetail(let id):
            return "/games/\(id)?key=\(APIConstant.apiKey)"
        }
    }

    var url: URL? {
        return URL(string: APIConstant.baseURL + value)
    }
}
