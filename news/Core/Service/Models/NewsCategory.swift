//
//  NewsCategory.swift
//  news
//
//  Created by Barış Dilekçi on 23.05.2025.
//

import Foundation

enum NewsCategory: String, CaseIterable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"

    var displayName: String {
        switch self {
        case .business: return "İş Dünyası"
        case .entertainment: return "Eğlence"
        case .general: return "Genel"
        case .health: return "Sağlık"
        case .science: return "Bilim"
        case .sports: return "Spor"
        case .technology: return "Teknoloji"
        }
    }
}


