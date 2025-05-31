//
//  MainTabBarController.swift
//  news
//
//  Created by Barış Dilekçi on 31.05.2025.
//

import Foundation
import UIKit

protocol MainTabBarRouterProtocol: AnyObject {
    var tabBarController: UITabBarController? { get }
    static func createTabBar() -> MainTabBarRouterProtocol
}

final class MainTabBarRouter: MainTabBarRouterProtocol {
    
    var tabBarController: UITabBarController?
    
    static func createTabBar() -> MainTabBarRouterProtocol {
        let router = MainTabBarRouter()
        router.setupTabBar()
        return router
    }
    
    private func setupTabBar() {
        let tabBar = UITabBarController()
 
        let homeNavController = HomeRouter.startExecution() 
        
        homeNavController.tabBarItem = UITabBarItem(
            title: "Ana Sayfa",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let favoritesRouter = FavoritesRouter.startExecution()
        guard let favoritesVC = favoritesRouter.entry else { return }
        
        let favoritesNavController = UINavigationController(rootViewController: favoritesVC)
        favoritesNavController.tabBarItem = UITabBarItem(
            title: "Favoriler",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        // TabBar appearance
        tabBar.tabBar.tintColor = .systemBlue
        tabBar.tabBar.backgroundColor = .systemBackground
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            
            tabBar.tabBar.standardAppearance = appearance
            tabBar.tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.viewControllers = [homeNavController, favoritesNavController]
        
        self.tabBarController = tabBar
    }
}
