//
//  DetailInteractor.swift
//  news
//
//  Created by Barış Dilekçi on 24.05.2025.
//

import Foundation

protocol DetailInteractorProtocol : AnyActor {
    var presenter : DetailPresenterProtocol? { get set }
}

final class DetailInteractor : DetailInteractorProtocol {
    var presenter: (any DetailPresenterProtocol)?
    
    
}
