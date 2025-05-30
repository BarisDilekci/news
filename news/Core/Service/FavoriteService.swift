//
//  FavoriteService.swift
//  news
//
//  Created by Barış Dilekçi on 29.05.2025.
//

import Foundation

// FavoriteService.swift
protocol FavoriteServiceProtocol: AnyObject {
    func addFavorite(news: News)
    func removeFavorite(news: News)
    func getFavorites() -> [News]
    func isFavorite(news: News) -> Bool // Bir haberin favori olup olmadığını kontrol et
}

class FavoriteService: FavoriteServiceProtocol {
    private let favoritesKey = "favoriteNews"

    func addFavorite(news: News) {
        var favorites = getFavorites()
        // Hata buradaydı. 'contains(where: news)' yerine 'contains(news)' olacak.
        // News modeli Equatable olduğu için doğrudan 'contains(Element)' metodunu kullanabiliriz.
        if !favorites.contains(news) {
            favorites.append(news)
            saveFavorites(favorites)
        }
    }

    func removeFavorite(news: News) {
        var favorites = getFavorites()
        // Burada doğru kullanılmıştı zaten.
        favorites.removeAll(where: { $0 == news })
        saveFavorites(favorites)
    }

    func getFavorites() -> [News] {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            if let decodedNews = try? JSONDecoder().decode([News].self, from: data) {
                return decodedNews
            }
        }
        return []
    }

    func isFavorite(news: News) -> Bool {
        return getFavorites().contains(news)
    }

    private func saveFavorites(_ favorites: [News]) {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
}
