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
    case gameSearch(page: Int, name: String)
    
    var value: String {
        switch self {
        case .games(let page):
            return "/games?key=\(APIConstant.apiKey)&page=\(page)"
        case .gameDetail(let id):
            return "/games/\(id)?key=\(APIConstant.apiKey)"
        case .gameSearch(let page, let name):
            let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
            return "/games?key=\(APIConstant.apiKey)&page=\(page)\(APIConstant.search)\(encodedName)"
        }
    }
    
    var url: URL? {
        return URL(string: APIConstant.baseURL + value)
    }
}
