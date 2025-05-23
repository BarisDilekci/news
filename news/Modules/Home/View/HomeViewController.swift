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
    
    lazy var homeView: HomeView = {
        let view = HomeView()
        view.backgroundColor = ThemeManager.defaultTheme.colorTheme.background
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        title = "Haberler"
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        
        // Presenter'ı HomeView'a bağla
        homeView.presenter = presenter
        presenter?.view = homeView // HomeView artık HomeViewProtocol implement ediyor
        
        // İlk yükleme
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        // Navigation bar'ı şeffaf yapmak için
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - HomeViewProtocol
    func updateViewWithNews(_ news: [News]) {
        print("✅ Haberler geldi: \(news.count) adet")
        DispatchQueue.main.async {
            self.homeView.updateViewWithNews(news)
        }
    }
    
    func showError(_ message: String) {
        print("❌ Hata: \(message)")
        DispatchQueue.main.async {
            self.showErrorAlert(message: message)
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    func homeView(_ homeView: HomeView, didSelectCountry country: NewsCountry, category: NewsCategory, language: NewsLanguage) {
        print("🔄 Filtreler seçildi - Ülke: \(country.displayName), Kategori: \(category.displayName), Dil: \(language.displayName)")
        
        // Loading göster
        homeView.showLoading(true)
        
        // Presenter'a filtreleri bildir
        presenter?.didSelectFilters(country: country, category: category, language: language)
    }
}
