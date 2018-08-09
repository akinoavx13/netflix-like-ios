//
//  SearchCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

class SearchCoordinator: Coordinator {
    
    // MARK: - Properties -
    let navigationController: UINavigationController
    // NOTE: This array is used to retain child coordinators. Don't forget to
    // remove them when the coordinator is done.
    var children: [Coordinator]
//    weak var delegate: SearchCoordinatorDelegate?

    // MARK: - Lifecycle -
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.children = []
    }

    // MARK: - Methods -
    func start() {
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor, coordinator: self)
        let viewController = SearchViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = viewController

        navigationController.setViewControllers([viewController], animated: false)
    }
}

// PRESENTER -> COORDINATOR
extension SearchCoordinator: SearchCoordinatorInput {

}
