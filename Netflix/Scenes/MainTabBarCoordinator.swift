//
//  MainTabBarCoordinator.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//
import UIKit
import XCoordinator

enum MainTabBarRoute: Route {
    case movies
}

final class MainTabBarCoordinator: TabBarCoordinator<MainTabBarRoute> {
    // MARK: - Properties

    private let moviesRouter: StrongRouter<MoviesRoute>

    // MARK: - Lifecycle

    convenience init() {
        let moviesCoordinator = MoviesCoordinator()
        moviesCoordinator.rootViewController.tabBarItem = UITabBarItem(
            tabBarSystemItem: .topRated,
            tag: 0
        )

        self.init(moviesRouter: moviesCoordinator.strongRouter)
    }

    init(moviesRouter: StrongRouter<MoviesRoute>) {
        self.moviesRouter = moviesRouter

        super.init(tabs: [moviesRouter], select: moviesRouter)
    }

    // MARK: - Methods

    override func prepareTransition(for route: MainTabBarRoute)
        -> TabBarTransition
    {
        switch route {
        case .movies:
            return .select(moviesRouter)
        }
    }
}
