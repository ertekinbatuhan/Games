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
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

// MARK: - Network Manager Implementation
class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Request Data Method
    /// Fetches data from the specified network path and decodes it into the specified type.
    /// - Parameters:
    ///   - path: The network path to fetch data from.
    ///   - type: The type to decode the data into, which must conform to `Codable`.
    ///   - completion: A closure that is called when the request is complete.
    ///     It returns a `Result` containing either the decoded data of type `T` or an `Error`.
    func requestData<T: Codable>(
        path: NetworkPath,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        // MARK: - URL Validation
        guard let url = path.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // MARK: - Create Data Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // MARK: - Error Handling
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // MARK: - Response Validation
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            // MARK: - Data Validation
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // MARK: - Data Decoding
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }.resume()
    }
}
