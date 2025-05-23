//
//  HomePresenter.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import Foundation
import UIKit


protocol HomePresenterProtocol {
    var view:  HomeViewProtocol? { get set }
    var interactor : HomeInteractorProtocol? { get set }
    var router : HomeRouterProtocol? { get set }
    func viewDidLoad()
    
    func didSelectFilters(country: NewsCountry, category: NewsCategory, language: NewsLanguage)
    func didFetchNewsSuccess(_ news: [News])
    func didFetchNewsFailure(_ error: String)
}

final class HomePresenter: HomePresenterProtocol {
    var news: [News] = []
    var error: String?

    var interactor: HomeInteractorProtocol?
    var view: HomeViewProtocol?
    var router: HomeRouterProtocol?

    func viewDidLoad() {
        print("HomePresenter: View did load")
        interactor?.fetchNews(country: .us, category: .general, language: .en)
    }
    
    func didSelectFilters(country: NewsCountry, category: NewsCategory, language: NewsLanguage) {
           print("HomePresenter: Filters selected - Country: \(country.rawValue), Category: \(category.rawValue), Language: \(language.rawValue)")
           interactor?.fetchNews(country: country, category: category, language: language)
       }

    func didFetchNewsSuccess(_ news: [News]) {
        self.news = news
        view?.updateViewWithNews(news)
    }

    func didFetchNewsFailure(_ error: String) {
        self.error = error
        view?.showError(error)
    }
}
