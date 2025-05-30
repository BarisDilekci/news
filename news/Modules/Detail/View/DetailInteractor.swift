//
//  DetailInteractor.swift
//  news
//
//  Created by Barış Dilekçi on 24.05.2025.
//

import Foundation

protocol DetailInteractorProtocol : AnyActor {
    var presenter : DetailPresenterProtocol? { get set }
    
    func toggleFavoriteStatus(for news : News)
}

final class DetailInteractor : DetailInteractorProtocol {
    weak var presenter: (any DetailPresenterProtocol)?
    
    private let favoriteService : FavoriteServiceProtocol
    
    init(favoriteService : FavoriteServiceProtocol) {
        self.favoriteService = favoriteService
    }
    
    func toggleFavoriteStatus(for news: News) {
        
        let currentlyFavorite = favoriteService.isFavorite(news: news)
        
        if currentlyFavorite {
            favoriteService.removeFavorite(news: news)
        } else {
            favoriteService.addFavorite(news: news)
        }
        
        NotificationCenter.default.post(name: .favoriteStatusChanged, object: nil)
    }
}
