//
//  DetailRouter.swift
//  news
//
//  Created by Barış Dilekçi on 24.05.2025.
//

import Foundation
import UIKit

typealias DetailEntryPoint = DetailViewProtocol & UIViewController


protocol DetailRouterProtocol : AnyObject {
    var entry : DetailEntryPoint? { get }
    static func startExecution() -> DetailRouterProtocol
}


final class DetailRouter : DetailRouterProtocol {
    
    var entry : DetailEntryPoint?
    
    static func startExecution() -> any DetailRouterProtocol {
        let router = DetailRouter()
        
        let view = DetailViewController()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as! any DetailEntryPoint
        
        return router
        
    }
    
}
