//
//  NetworkManager.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 24.09.2024.
//

import Foundation

// MARK: - NetworkManagerProtocol
protocol NetworkManagerProtocol {
    func requestData<T: Codable>(
        path: NetworkPath,
        type: T.Type
    ) async throws -> T
}

// MARK: - Network Manager Implementation
final class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Request Data Method
    /// Fetches data from the specified network path and decodes it into the specified type.
    /// - Parameters:
    ///   - path: The network path to fetch data from.
    ///   - type: The type to decode the data into, which must conform to `Codable`.
    /// - Returns: The decoded data of type `T`.
    /// - Throws: An error if the request fails or if the data cannot be decoded.
    func requestData<T: Codable>(
        path: NetworkPath,
        type: T.Type
    ) async throws -> T {
        // MARK: - URL Validation
        guard let url = path.url else {
            throw NetworkError.invalidURL
        }
        
        // MARK: - Perform Request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // MARK: - Response Validation
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        // MARK: - Data Decoding
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

