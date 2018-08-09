//
//  BookmarksCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

class BookmarksCoordinator: Coordinator {
    
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
        let interactor = BookmarksInteractor()
        let presenter = BookmarksPresenter(interactor: interactor, coordinator: self)
        let viewController = BookmarksViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = viewController

        navigationController.setViewControllers([viewController], animated: false)
    }
}

// PRESENTER -> COORDINATOR
extension BookmarksCoordinator: BookmarksCoordinatorInput {
    func showDetailsOf(id: Int, type: Item.ContentType) {
        let coordinator = DetailsCoordinator(navigationController: navigationController, id: id, type: type)
        children = [coordinator]
        coordinator.start()
    }
}
