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
}

final class DetailPresenter : DetailPresenterProtocol {
    var view: (any DetailViewProtocol)?
    
    var interactor: (any DetailInteractorProtocol)?
    
    var router: (any DetailRouterProtocol)?
    
    private var newsItem : News?
    
    func viewDidLoad() {
        if let news = newsItem {
            
        }
    }
    
    func setNews(newsItem: News) {
           self.newsItem = newsItem
           if view != nil {
               view?.displayNews(newsItem: newsItem)
           }
       }
    
}

