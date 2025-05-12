//
//  HomeInteractor.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import Foundation

protocol HomeInteractorProtocol : AnyObject {
    var presenter: HomePresenterProtocol? { get set }
}

final class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
}
