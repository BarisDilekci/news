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
    static func startExecution() -> HomeRouterProtocol
}

import UIKit

final class HomeRouter: HomeRouterProtocol {
    var entry: EntryPoint?

    static func startExecution() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        // VIPER parçaları oluşturuluyor
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(networkService: NetworkService.shared)
        
        // Bağlantılar yapılıyor
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as! any EntryPoint
        return router
    }
}
