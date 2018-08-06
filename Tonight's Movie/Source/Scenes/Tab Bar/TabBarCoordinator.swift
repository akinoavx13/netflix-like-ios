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
    }
    
    // MARK: - Methods -
    func start() {
        addScene(with: .discover)
        
        window.updateRootViewController(with: tabBarController)
    }
    
    private func addScene(with tab: Tab) {
        let navigationController = UINavigationController()
        
        var viewControllers = tabBarController.viewControllers ?? []
        viewControllers += [navigationController]
        tabBarController.setViewControllers(viewControllers, animated: true)
        
        let coordinator: Coordinator
        
        switch tab {
        case .discover:
            coordinator = DiscoverCoordinator(navigationController: navigationController)
        }
        
        children.append(coordinator)
        coordinator.start()
    }
}

