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
        view.backgroundColor = ThemeManager.defaultTheme.colorTheme.background
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News"
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


