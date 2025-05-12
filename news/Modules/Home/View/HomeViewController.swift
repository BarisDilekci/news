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
    
    lazy var homeView : HomeView = {
        let view = HomeView()
        view.backgroundColor = .systemBackground
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        presenter?.viewDidLoad()
    }
    
    private func updatePresenter(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        homeView.presenter
    }
}


