//
//  NetworkError.swift
//  news
//
//  Created by Barış Dilekçi on 15.05.2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Decoding error"
        case .serverError(let message):
            return "Server error: \(message)"
        }
    }
}
