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
    func updateViewWithNews(_ news: [News])
    func showError(_ message: String)
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
        
        if let homeViewProtocol = homeView as? HomeViewProtocol {
            presenter?.view = homeViewProtocol
        } else {
            print("HomeView, HomeViewProtocol'e dönüştürülemedi.")
        }
        homeView.presenter = presenter
    }
    
    private func updatePresenter(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        homeView.presenter
    }
    
    func updateViewWithNews(_ news: [News]) {
        print("✅ Haberler geldi: \(news)")
        homeView.updateNewsCollectionView(items: news)
    }
    
    func showError(_ message: String) {
        print("❌ Hata: \(message)")
    }
    
}


