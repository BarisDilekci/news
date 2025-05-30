//
//  DetailViewController.swift
//  news
//
//  Created by Barış Dilekçi on 24.05.2025.
//

import UIKit
import SDWebImage

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    func displayNews(newsItem: News)
    func updateFavoriteButtonState(isFavorite: Bool)
}

final class DetailViewController: UIViewController, DetailViewProtocol {

    var presenter: DetailPresenterProtocol?
    private let detailView = DetailView()
    private var favoriteButton: UIBarButtonItem?

    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupNotificationObserver()
        presenter?.viewDidLoad()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupNavigationBar() {
        title = "Haber Detayı"

        favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoriteStatusDidChange),
            name: .favoriteStatusChanged,
            object: nil
        )
    }
    
    @objc private func favoriteStatusDidChange() {
        presenter?.favoriteStatusDidChange()
    }

    @objc private func favoriteButtonTapped() {
        presenter?.didTapFavoriteButton()
    }

    func displayNews(newsItem: News) {
        detailView.titleLabel.text = newsItem.title
        detailView.descriptionLabel.text = newsItem.description

        if let urlStr = newsItem.urlToImage, let url = URL(string: urlStr) {
            detailView.imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        } else {
            detailView.imageView.image = UIImage(systemName: "photo")
        }
    }

    func updateFavoriteButtonState(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton?.image = UIImage(systemName: imageName)
    }
}
