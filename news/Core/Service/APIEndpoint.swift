//
//  APIEndpoint.swift
//  news
//
//  Created by Barış Dilekçi on 15.05.2025.
//

import Foundation

enum APIEndpoint {
    static let baseURL = "https://newsapi.org/v2"
    static let apiKey = "02592f307fce4acbb3890967aba7aedc"
    
    case topHeadlines(country: String, category: String? = nil)
    
    var path: String {
        switch self {
        case .topHeadlines:
            return "/top-headlines"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .topHeadlines(let country, let category):
            var items = [
                URLQueryItem(name: "country", value: country),
                URLQueryItem(name: "apiKey", value: APIEndpoint.apiKey)
            ]
            if let category = category {
                items.append(URLQueryItem(name: "category", value: category))
            }
            return items
        }
    }
    
    var url: URL? {
        var components = URLComponents(string: APIEndpoint.baseURL + path)
        components?.queryItems = queryItems
        return components?.url
    }
}
