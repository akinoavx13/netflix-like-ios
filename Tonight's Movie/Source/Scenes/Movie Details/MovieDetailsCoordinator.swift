//
//  MovieDetailsCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsCoordinator: Coordinator {
    
    // MARK: - Properties -
    var children: [Coordinator]
    
    private let navigationController: UINavigationController

    // MARK: - Lifecycle -
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.children = []
    }

    // MARK: - Methods -
    func start() {
        let interactor = MovieDetailsInteractor()
        let presenter = MovieDetailsPresenter(interactor: interactor, coordinator: self)
        let viewController = MovieDetailsViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = viewController
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

// PRESENTER -> COORDINATOR
extension MovieDetailsCoordinator: MovieDetailsCoordinatorInput {

}
