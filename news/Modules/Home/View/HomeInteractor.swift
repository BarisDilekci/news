//
//  HomeInteractor.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import Foundation

protocol HomeInteractorProtocol : AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    func fetchNews(country: NewsCountry, category: NewsCategory, language: NewsLanguage)
}

final class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
    
    private let networkService : NetworkServiceProtocol
    
    init(networkService : NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchNews(country: NewsCountry, category: NewsCategory, language: NewsLanguage) {
        Task {
            do {
                let response: NewsResponse = try await networkService.fetch(
                    endpoint: .topHeadlines(
                        country: country.rawValue,
                        category: category.rawValue,
                        language: language.rawValue 
                    )
                )
                await MainActor.run {
                    presenter?.didFetchNewsSuccess(response.articles)
                }
            } catch {
                await MainActor.run {
                    presenter?.didFetchNewsFailure(error.localizedDescription)
                }
            }
        }
    }
}
