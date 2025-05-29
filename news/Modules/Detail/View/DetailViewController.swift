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
}

final class DetailViewController: UIViewController, DetailViewProtocol {

    var presenter: DetailPresenterProtocol?
    private let detailView = DetailView()

    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
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
}
