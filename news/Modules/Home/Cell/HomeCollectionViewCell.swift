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
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
        label.textColor = ThemeColor.defaultTheme.secondaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.defaultTheme.cardBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(newsImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            newsImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: 180),
            
            titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with news: News) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        
        if let imageURLString = news.urlToImage, let url = URL(string: imageURLString) {
            newsImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "no-found-image"))
        } else {
            newsImageView.image = UIImage(named: "no-found-image")
        }
        
    }
}
