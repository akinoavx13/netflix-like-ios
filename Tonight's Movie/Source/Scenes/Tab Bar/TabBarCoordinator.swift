//
//  TabBarCoordinator.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties -
    var children: [Coordinator]
    
    private let window: UIWindow
    private let tabBarController: UITabBarController
    
    private enum Tab {
        case DiscoverMovies, DiscoverTVShows, Search, Bookmarks
    }
    
    // MARK: - Lifecycle -
    init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
        children = []
        
        setupTabBar()
    }
    
    // MARK: - Methods -
    func start() {
        addScene(with: .DiscoverMovies)
        addScene(with: .DiscoverTVShows)
        addScene(with: .Search)
        addScene(with: .Bookmarks)
        
        window.updateRootViewController(with: tabBarController)
    }
    
    func setupTabBar() {
        tabBarController.tabBar.barTintColor = Colors.black
        tabBarController.tabBar.tintColor = Colors.white
    }
    
    private func addScene(with tab: Tab) {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        Style.NavigationController.edit(navigationController)
        
        var viewControllers = tabBarController.viewControllers ?? []
        viewControllers += [navigationController]
        tabBarController.setViewControllers(viewControllers, animated: true)
        
        let coordinator: Coordinator
        
        switch tab {
        case .DiscoverMovies:
            coordinator = DiscoverCoordinator(navigationController: navigationController, screen: .Movies)
            navigationController.tabBarItem = UITabBarItem(title: Translation.Default.movies, image: Icons.discoverMovies, selectedImage: nil)
        case .DiscoverTVShows:
            coordinator = DiscoverCoordinator(navigationController: navigationController, screen: .TVShows)
            navigationController.tabBarItem = UITabBarItem(title: Translation.Default.tvShows, image: Icons.discoverTVShows, selectedImage: nil)
        case .Search:
            coordinator = SearchCoordinator(navigationController: navigationController)
            navigationController.tabBarItem = UITabBarItem(title: Translation.Search.search, image: Icons.search, selectedImage: nil)
        case .Bookmarks:
            coordinator = BookmarksCoordinator(navigationController: navigationController)
            navigationController.tabBarItem = UITabBarItem(title: Translation.Bookmarks.bookmarks, image: Icons.bookmark, selectedImage: nil)
        }
        
        children.append(coordinator)
        coordinator.start()
    }
}

