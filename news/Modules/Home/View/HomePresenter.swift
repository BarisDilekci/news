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
}

final class HomePresenter : HomePresenterProtocol {
    var interactor: (any HomeInteractorProtocol)?
    
    var view: (any HomeViewProtocol)?
    
    var router: (any HomeRouterProtocol)?
    
    func viewDidLoad() {
        print("HomePresenter: View did load")
       
    }
}
