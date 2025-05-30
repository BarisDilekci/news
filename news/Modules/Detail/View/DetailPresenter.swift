//
//  DetailPresenter.swift
//  news
//
//  Created by Barış Dilekçi on 24.05.2025.
//
import Foundation

protocol DetailPresenterProtocol : AnyObject {
    var view : DetailViewProtocol? { get set }
    var interactor : DetailInteractorProtocol? { get set }
    var router : DetailRouterProtocol? { get set }
    
    func viewDidLoad()
    
    func setNews(newsItem : News)
    func didTapFavoriteButton()
    func favoriteStatusDidChange()
}

final class DetailPresenter : DetailPresenterProtocol {
    var view: (any DetailViewProtocol)?
    
    var interactor: (any DetailInteractorProtocol)?
    
    var router: (any DetailRouterProtocol)?
    
    private var newsItem : News?
    private let favoriteService: FavoriteServiceProtocol
    
    init(favoriteService: FavoriteServiceProtocol) {
        self.favoriteService = favoriteService
    }
    
    func viewDidLoad() {
        
        guard let item = newsItem else {
            print("Hata: newsItem atanmamış!")
            return
        }
        
        view?.displayNews(newsItem: item)
        
        let isFavorite = favoriteService.isFavorite(news: item)
        view?.updateFavoriteButtonState(isFavorite: isFavorite)
    }
    
    func setNews(newsItem: News) {
        self.newsItem = newsItem
        view?.displayNews(newsItem: newsItem)
        
        let isFavorite = favoriteService.isFavorite(news: newsItem)
        view?.updateFavoriteButtonState(isFavorite: isFavorite)
    }
    
    func didTapFavoriteButton() {
        guard let item = newsItem else { return }
        
        let currentFavoriteStatus = favoriteService.isFavorite(news: item)
        
        interactor?.toggleFavoriteStatus(for: item)
        
        view?.updateFavoriteButtonState(isFavorite: !currentFavoriteStatus)
    }
    
    func favoriteStatusDidChange() {
        guard let item = newsItem else { return }
        
        let isFavorite = favoriteService.isFavorite(news: item)
        view?.updateFavoriteButtonState(isFavorite: isFavorite)
    }
}
