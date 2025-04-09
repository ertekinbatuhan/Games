//
//  MockNetworkManager.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 28.09.2024.
//

import SwiftUI
@testable import Games
// MARK: - Mock Network Manager
final class MockNetworkManager: NetworkManagerProtocol {
    var result: Result<Data, Error>?
    
    func requestData<T: Codable>(
        path: NetworkPath,
        type: T.Type
    ) async throws -> T {
        guard let result = result else {
            throw NSError(domain: "MockNetworkManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No result set"])
        }
        
        switch result {
        case .success(let data):
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingError(error)
            }
        case .failure(let error):
            throw error
        }
    }
}
