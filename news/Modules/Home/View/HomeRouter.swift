//
//  HomeRouter.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import Foundation
import UIKit

typealias EntryPoint = HomeViewProtocol & UIViewController

protocol HomeRouterProtocol: AnyObject {
    var entry: EntryPoint? { get }
    static func startExecution() -> UIViewController 
    func navigateToDetail(with newsItem: News)
}

final class HomeRouter: HomeRouterProtocol {

    weak var entry: EntryPoint?

    static func startExecution() -> UIViewController {
        let router = HomeRouter()

        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(networkService: NetworkService.shared)

        view.presenter = presenter

        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor

        interactor.presenter = presenter

        guard let entryPointView = view as? EntryPoint else {
            fatalError("HomeViewController could not be cast to EntryPoint.")
        }
        router.entry = entryPointView

        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }

    func navigateToDetail(with newsItem: News) {
        let detailRouter = DetailRouter.startExecution()

        if let detailPresenter = detailRouter.entry?.presenter as? DetailPresenterProtocol {
            detailPresenter.setNews(newsItem: newsItem)
        } else {
            print("Hata: DetailPresenterProtocol'e erişilemedi veya setNews metodu bulunamadı.")
        }

     
        if let currentNavigationController = entry?.navigationController {
            guard let detailEntry = detailRouter.entry else {
                print("Hata: Detail modülünün giriş noktası (entry) nil.")
                return
            }
            currentNavigationController.pushViewController(detailEntry, animated: true)
        } else {
            print("Hata: Home modülünün navigationController'ına erişilemedi. Detay ekranı gösterilemedi.")
        
        }
    }
}
