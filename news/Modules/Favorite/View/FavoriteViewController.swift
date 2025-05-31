//
//  FavoriteViewController.swift
//  news
//
//  Created by Barış Dilekçi on 31.05.2025.
//

import Foundation
import UIKit
import SDWebImage

protocol FavoritesViewProtocol: AnyObject {
    var presenter: FavoritesPresenterProtocol? { get set }
    func setupUI()
    func reloadData()
    func showEmptyState()
    func showFavorites()
}

final class FavoritesViewController: UIViewController, FavoritesViewProtocol {
    
    var presenter: FavoritesPresenterProtocol?
    private let favoritesView = FavoritesView()
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    func setupUI() {
        title = "Favorilerim"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
        favoritesView.tableView.register(FavoriteNewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.favoritesView.tableView.reloadData()
        }
    }
    
    func showEmptyState() {
        DispatchQueue.main.async {
            self.favoritesView.showEmptyState(true)
        }
    }
    
    func showFavorites() {
        DispatchQueue.main.async {
            self.favoritesView.showEmptyState(false)
        }
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfFavorites() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? FavoriteNewsTableViewCell,
              let news = presenter?.favoriteNews(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configure(with: news)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectFavorite(at: indexPath.row)
    }
    
    // Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.didSwipeToDelete(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Kaldır"
    }
}
