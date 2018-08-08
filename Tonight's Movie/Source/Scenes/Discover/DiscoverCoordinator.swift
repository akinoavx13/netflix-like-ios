//
//  DiscoverCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

class DiscoverCoordinator: Coordinator {
    
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
        let interactor = DiscoverInteractor()
        let presenter = DiscoverPresenter(interactor: interactor, coordinator: self)
        let viewController = DiscoverViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = viewController

        navigationController.setViewControllers([viewController], animated: false)
    }
}

// PRESENTER -> COORDINATOR
extension DiscoverCoordinator: DiscoverCoordinatorInput {
    func createItemList(section: ItemList.Section) {
        let coodinator = ItemListCoordinator(navigationController: navigationController, section: section)
        children.append(coodinator)
        coodinator.start()
    }
    
    func startItemListCoordinator(viewController: DiscoverViewController, for cell: DiscoverCell, at indexPath: IndexPath) {
        guard
            children.count >= indexPath.row,
            let coordinator = children[indexPath.row] as? ItemListCoordinator
        else { return }
        
        coordinator.show(viewController: viewController, for: cell)
    }
    
    func stopItemListCoordinator(at indexPath: IndexPath) {
        guard
            children.count >= indexPath.row,
            let coordinator = children[indexPath.row] as? ItemListCoordinator
        else { return }
        
        coordinator.stop()
    }
}
