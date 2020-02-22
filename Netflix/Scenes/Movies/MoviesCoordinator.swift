//
//  MoviesCoordinator.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator

enum MoviesRoute: Route {
    case home
}

final class MoviesCoordinator: NavigationCoordinator<MoviesRoute> {
    // MARK: - Lifecycle

    init() {
        super.init(initialRoute: .home)
    }

    // MARK: - Methods

    override func prepareTransition(for route: MoviesRoute)
        -> NavigationTransition
    {
        switch route {
        case .home:
            let viewController = MoviesViewController()
            let viewModel = MoviesViewModel(router: unownedRouter)
            viewController.bind(to: viewModel)
            return .push(viewController)
        }
    }
}
