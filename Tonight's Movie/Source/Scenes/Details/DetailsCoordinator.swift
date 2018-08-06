//
//  DetailsCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

class DetailsCoordinator: Coordinator {
    
    // MARK: - Properties -
    private let navigationController: UINavigationController
    
    var children: [Coordinator]
    
    private let id: Int
    private let type: Details.ContentType

    // MARK: - Lifecycle -
    init(navigationController: UINavigationController, type: Details.ContentType, id: Int) {
        self.navigationController = navigationController
        self.children = []
        self.type = type
        self.id = id
    }

    // MARK: - Methods -
    func start() {
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter(interactor: interactor, coordinator: self, type: type, id: id)
        let viewController = DetailsViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = viewController

        navigationController.pushViewController(viewController, animated: true)
    }
}

// PRESENTER -> COORDINATOR
extension DetailsCoordinator: DetailsCoordinatorInput {

}
