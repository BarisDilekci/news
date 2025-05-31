//
//  FavoritePresenter.swift
//  news
//
//  Created by Barış Dilekçi on 31.05.2025.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    var view: FavoritesViewProtocol? { get set }
    var interactor: FavoritesInteractorProtocol? { get set }
    var router: FavoritesRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func numberOfFavorites() -> Int
    func favoriteNews(at index: Int) -> News
    func didSelectFavorite(at index: Int)
    func didSwipeToDelete(at index: Int)
    func didFetchFavorites(_ favorites: [News])
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    var view: (any FavoritesViewProtocol)?
    var interactor: (any FavoritesInteractorProtocol)?
    var router: (any FavoritesRouterProtocol)?
    
    private var favorites: [News] = []
    
    func viewDidLoad() {
        view?.setupUI()
        interactor?.fetchFavorites()
    }
    
    func viewWillAppear() {
        interactor?.fetchFavorites()
    }
    
    func numberOfFavorites() -> Int {
        return favorites.count
    }
    
    func favoriteNews(at index: Int) -> News {
        return favorites[index]
    }
    
    func didSelectFavorite(at index: Int) {
        let selectedNews = favorites[index]
        router?.navigateToDetail(with: selectedNews)
    }
    
    func didSwipeToDelete(at index: Int) {
        let newsToRemove = favorites[index]
        interactor?.removeFavorite(news: newsToRemove)
    }
    
    func didFetchFavorites(_ favorites: [News]) {
        self.favorites = favorites
        
        if favorites.isEmpty {
            view?.showEmptyState()
        } else {
            view?.showFavorites()
            view?.reloadData()
        }
    }
}
