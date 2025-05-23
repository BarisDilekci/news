//
//  HomeView.swift
//  news
//
//  Created by Barış Dilekçi on 12.05.2025.

import UIKit
import Lottie

// MARK: - Protocols
protocol HomeViewDelegate: AnyObject {
    func homeView(_ homeView: HomeView, didSelectCountry country: NewsCountry, category: NewsCategory, language: NewsLanguage)
}

protocol HomeViewInput: AnyObject {
    func updateNewsCollectionView(items: [News])
    func showLoading(_ isLoading: Bool)
    var presenter: HomePresenterProtocol? { get set }
}

final class HomeView: UIView, HomeViewInput, HomeViewProtocol {
    
    // MARK: - Properties
    var presenter: HomePresenterProtocol?
    weak var delegate: HomeViewDelegate?
    
    private var newsItems: [News] = []
    
    // Seçenekler
    private let countries = NewsCountry.allCases
    private let categories = NewsCategory.allCases
    private let languages = NewsLanguage.allCases
    
    // Kullanıcının seçtiği enum değerlerini tutuyoruz
    private var selectedCountry: NewsCountry = .us {
        didSet { updateFilterChips() }
    }
    private var selectedCategory: NewsCategory = .general {
        didSet { updateFilterChips() }
    }
    private var selectedLanguage: NewsLanguage = .en {
        didSet { updateFilterChips() }
    }
    
    // MARK: - UI Components
    private let animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "loading")
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.isHidden = true
        return animation
    }()
    
    // Filter ScrollView (WhatsApp tarzı)
    private lazy var filterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Filter Chips
    private lazy var countryChip: UIButton = {
        let button = createFilterChip(title: selectedCountry.displayName, tag: 0)
        button.addTarget(self, action: #selector(filterChipTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var categoryChip: UIButton = {
        let button = createFilterChip(title: selectedCategory.displayName, tag: 1)
        button.addTarget(self, action: #selector(filterChipTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var languageChip: UIButton = {
        let button = createFilterChip(title: selectedLanguage.displayName, tag: 2)
        button.addTarget(self, action: #selector(filterChipTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // Collection View
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 20, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // Refresh Control
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        return refresh
    }()
    
    // Empty State View
    private lazy var emptyStateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        let imageView = UIImageView(image: UIImage(systemName: "newspaper"))
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Filtrelerinizi seçip haberleri yükleyin"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupDelegates()
        updateFilterChips()
        backgroundColor = UIColor.systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(filterScrollView)
        addSubview(collectionView)
        addSubview(emptyStateView)
        addSubview(animationView)
        
        filterScrollView.addSubview(filterStackView)
        
        // Filter chips'i stack view'e ekle
        filterStackView.addArrangedSubview(countryChip)
        filterStackView.addArrangedSubview(categoryChip)
        filterStackView.addArrangedSubview(languageChip)
        
        // Refresh control ekle
        collectionView.addSubview(refreshControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Filter ScrollView
            filterScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            filterScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterScrollView.heightAnchor.constraint(equalToConstant: 50),
            
            // Filter StackView
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.topAnchor, constant: 8),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor, constant: -8),
            filterStackView.heightAnchor.constraint(equalTo: filterScrollView.heightAnchor, constant: -16),
            
            // Collection View
            collectionView.topAnchor.constraint(equalTo: filterScrollView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Empty State View
            emptyStateView.topAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Animation View
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 120),
            animationView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Helper Methods
    private func createFilterChip(title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 17
        button.tag = tag
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Padding
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left:16, bottom: 8, right: 16)
        
        // Height constraint
        button.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        return button
    }
    
    @objc private func buttonTouchDown() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    private func updateFilterChips() {
        countryChip.setTitle(selectedCountry.displayName, for: .normal)
        categoryChip.setTitle(selectedCategory.displayName, for: .normal)
        languageChip.setTitle(selectedLanguage.displayName, for: .normal)
        
        // Otomatik olarak haberleri getir
        fetchNewsAutomatically()
    }
    
    private func fetchNewsAutomatically() {
        // Kısa bir delay ile otomatik fetch
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.delegate?.homeView(self, didSelectCountry: self.selectedCountry, category: self.selectedCategory, language: self.selectedLanguage)
        }
    }
    
    // MARK: - Actions
    @objc private func filterChipTapped(_ sender: UIButton) {
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        
        // Chip animasyonu
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut]) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
        
        switch sender.tag {
        case 0: // Country
            showPickerAlert(for: .country)
        case 1: // Category
            showPickerAlert(for: .category)
        case 2: // Language
            showPickerAlert(for: .language)
        default:
            break
        }
    }
    
    @objc private func refreshNews() {
        delegate?.homeView(self, didSelectCountry: selectedCountry, category: selectedCategory, language: selectedLanguage)
    }
    
    // MARK: - Picker Alert
    enum FilterType {
        case country, category, language
    }
    
    private func showPickerAlert(for type: FilterType) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        switch type {
        case .country:
            alert.title = "Ülke Seçin"
            for country in countries {
                let action = UIAlertAction(title: country.displayName, style: .default) { _ in
                    self.selectedCountry = country
                }
                if country == selectedCountry {
                    action.setValue(UIImage(systemName: "checkmark"), forKey: "image")
                }
                alert.addAction(action)
            }
            
        case .category:
            alert.title = "Kategori Seçin"
            for category in categories {
                let action = UIAlertAction(title: category.displayName, style: .default) { _ in
                    self.selectedCategory = category
                }
                if category == selectedCategory {
                    action.setValue(UIImage(systemName: "checkmark"), forKey: "image")
                }
                alert.addAction(action)
            }
            
        case .language:
            alert.title = "Dil Seçin"
            for language in languages {
                let action = UIAlertAction(title: language.displayName, style: .default) { _ in
                    self.selectedLanguage = language
                }
                if language == selectedLanguage {
                    action.setValue(UIImage(systemName: "checkmark"), forKey: "image")
                }
                alert.addAction(action)
            }
        }
        
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
        
        // iPad için popover
        if let popover = alert.popoverPresentationController {
            popover.sourceView = self
            popover.sourceRect = CGRect(x: bounds.midX, y: bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        
        if let viewController = self.findViewController() {
            viewController.present(alert, animated: true)
        }
    }
    
    // MARK: - HomeViewInput & HomeViewProtocol
    func updateNewsCollectionView(items: [News]) {
        self.newsItems = items
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
            self.showLoading(false)
            self.updateEmptyState()
        }
    }
    
    func showLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.animationView.isHidden = !isLoading
            if isLoading {
                self.animationView.play()
                self.emptyStateView.isHidden = true
            } else {
                self.animationView.stop()
                self.updateEmptyState()
            }
        }
    }
    
    private func updateEmptyState() {
        emptyStateView.isHidden = !newsItems.isEmpty
        collectionView.isHidden = newsItems.isEmpty
    }
    
    func updateViewWithNews(_ news: [News]) {
        updateNewsCollectionView(items: news)
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.showLoading(false)
        }
        print("❌ Hata: \(message)")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: newsItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle news item selection
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
}

// MARK: - UIView Extension
extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
