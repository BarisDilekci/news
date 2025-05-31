//
//  FavoriteInteractor.swift
//  news
//
//  Created by Barış Dilekçi on 31.05.2025.
//

import Foundation

protocol FavoritesInteractorProtocol: AnyActor {
    var presenter: FavoritesPresenterProtocol? { get set }
    
    func fetchFavorites()
    func removeFavorite(news: News)
}

final class FavoritesInteractor: FavoritesInteractorProtocol {
    weak var presenter: (any FavoritesPresenterProtocol)?
    
    private let favoriteService: FavoriteServiceProtocol
    
    init(favoriteService: FavoriteServiceProtocol) {
        self.favoriteService = favoriteService
        setupNotificationObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoriteStatusChanged),
            name: .favoriteStatusChanged,
            object: nil
        )
    }
    
    @objc private func favoriteStatusChanged() {
        fetchFavorites()
    }
    
    func fetchFavorites() {
        let favorites = favoriteService.getFavorites()
        presenter?.didFetchFavorites(favorites)
    }
    
    func removeFavorite(news: News) {
        favoriteService.removeFavorite(news: news)
        NotificationCenter.default.post(name: .favoriteStatusChanged, object: nil)
    }
}
