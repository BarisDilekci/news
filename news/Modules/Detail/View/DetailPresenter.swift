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
}

final class DetailPresenter : DetailPresenterProtocol {
    var view: (any DetailViewProtocol)?
    
    var interactor: (any DetailInteractorProtocol)?
    
    var router: (any DetailRouterProtocol)?
    
    func viewDidLoad() {
        print("test")
    }
    
    
}

