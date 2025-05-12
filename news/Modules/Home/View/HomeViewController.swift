//
//  HomeViewController.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
}


final class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: (any HomePresenterProtocol)?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        presenter?.viewDidLoad()
    }
}


