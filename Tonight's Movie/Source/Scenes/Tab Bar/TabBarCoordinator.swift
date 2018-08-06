//
//  TabBarCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties -
    var children: [Coordinator]
    
    private let window: UIWindow
    private let tabBarController: UITabBarController
    
    private enum Tab {
        case discover
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
        addScene(with: .discover)
        
        window.updateRootViewController(with: tabBarController)
    }
    
    func setupTabBar() {
        tabBarController.tabBar.barTintColor = Colors.blueNights
        tabBarController.tabBar.tintColor = .white
    }
    
    private func addScene(with tab: Tab) {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        var viewControllers = tabBarController.viewControllers ?? []
        viewControllers += [navigationController]
        tabBarController.setViewControllers(viewControllers, animated: true)
        
        let coordinator: Coordinator
        
        switch tab {
        case .discover:
            coordinator = DiscoverCoordinator(navigationController: navigationController)
            navigationController.tabBarItem = UITabBarItem(title: Translation.Discover.title, image: Icons.discover, selectedImage: nil)
        }
        
        children.append(coordinator)
        coordinator.start()
    }
}

