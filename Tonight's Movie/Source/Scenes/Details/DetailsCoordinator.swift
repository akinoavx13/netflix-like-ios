//
//  DetailsCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

class DetailsCoordinator: Coordinator {
    
    // MARK: - Properties -
    var children: [Coordinator]
    
    private let navigationController: UINavigationController
    
    private let id: Int
    private let type: Item.ContentType
    
    // MARK: - Lifecycle -
    init(navigationController: UINavigationController, id: Int, type: Item.ContentType) {
        self.navigationController = navigationController
        self.id = id
        self.type = type
        
        children = []
    }

    // MARK: - Methods -
    func start() {
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter(interactor: interactor, coordinator: self, id: id, type: type)
        let viewController = DetailsViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = viewController

        navigationController.showDetailViewController(viewController, sender: nil)
    }
}

// PRESENTER -> COORDINATOR
extension DetailsCoordinator: DetailsCoordinatorInput {
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
