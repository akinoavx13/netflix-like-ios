//
//  AppCoordinator.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator

enum AppRoute: Route {
    case home
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    // MARK: - Lifecycle

    init() {
        super.init(initialRoute: .home)
    }

    // MARK: - Methods

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .home:
            return .presentFullScreen(MainTabBarCoordinator(), animation: .fade)
        }
    }
}
