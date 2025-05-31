//
//  FavoriteRouter.swift
//  news
//
//  Created by Barış Dilekçi on 31.05.2025.
//

import Foundation
import UIKit

typealias FavoritesEntryPoint = FavoritesViewProtocol & UIViewController

protocol FavoritesRouterProtocol: AnyObject {
    var entry: FavoritesEntryPoint? { get }
    static func startExecution() -> FavoritesRouterProtocol
    func navigateToDetail(with news: News)
}

final class FavoritesRouter: FavoritesRouterProtocol {
    
    var entry: FavoritesEntryPoint?
    
    static func startExecution() -> any FavoritesRouterProtocol {
        let router = FavoritesRouter()
        let favoriteServiceInstance = FavoriteService()
        
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor(favoriteService: favoriteServiceInstance)
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as! any FavoritesEntryPoint
        
        return router
    }
    
    func navigateToDetail(with news: News) {
        let detailRouter = DetailRouter.startExecution()
        
        guard let detailVC = detailRouter.entry,
              let detailPresenter = detailVC.presenter else {
            return
        }
        
        detailPresenter.setNews(newsItem: news)
        entry?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
