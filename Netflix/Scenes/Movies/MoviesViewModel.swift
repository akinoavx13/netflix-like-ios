//
//  MoviesViewModel.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator

protocol MoviesViewModelContract {

}

final class MoviesViewModel: MoviesViewModelContract {

    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>

    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>) {
        self.router = router
    }

}
