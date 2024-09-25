//
//  NetworkError.swift
//  Games
//
//  Created by Batuhan Berk Ertekin on 24.09.2024.
//

// MARK: - NetworkError Enumeration
enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
    case decodingError(Error)
}
