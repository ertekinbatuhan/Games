//
//  MockNetworkManager.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 28.09.2024.
//

@testable import Games
import SwiftUI
// MARK: - Mock Network Manager
class MockNetworkManager: NetworkManagerProtocol {
    var result: Result<Data, Error>?
    
    func requestData<T: Codable>(
        path: NetworkPath,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if let result = result {
            completion(result.flatMap { data in
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return .success(decodedData)
                } catch {
                    return .failure(NetworkError.decodingError(error))
                }
            })
        }
    }
}
