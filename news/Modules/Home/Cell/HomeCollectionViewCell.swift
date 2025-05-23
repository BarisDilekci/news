//
//  HomeViewcell.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.
//

import Foundation
import UIKit
import SDWebImage

final class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewsCell"

    // MARK: - UI Components

    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.defaultTheme.titleBoldFont
        label.numberOfLines = 2
        label.textColor = ThemeColor.defaultTheme.primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.defaultTheme.subTitleFont
        label.numberOfLines = 3
        label.textColor = ThemeColor.defaultTheme.secondaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.defaultTheme.cardBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.08
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        contentView.addSubview(cardView)

        cardView.addSubview(newsImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(sourceLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            newsImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 0),
            newsImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            newsImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0),
            newsImageView.heightAnchor.constraint(equalToConstant: 160),

            titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

            sourceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            sourceLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            sourceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            sourceLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Configuration

    func configure(with news: News) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description


        // Görsel yükleme
        if let imageURLString = news.urlToImage, let url = URL(string: imageURLString) {
            newsImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "no-found-image")) { [weak self] (image, error, cacheType, url) in
                if error != nil {
                    self?.newsImageView.image = UIImage(named: "no-found-image")
                }
            }
        } else {
            newsImageView.image = UIImage(named: "no-found-image")
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.sd_cancelCurrentImageLoad()
        newsImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        sourceLabel.text = nil
    }
}
