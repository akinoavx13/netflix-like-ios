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
    private let screen: Discover.Screen

    // MARK: - Lifecycle -
    init(navigationController: UINavigationController, screen: Discover.Screen) {
        self.navigationController = navigationController
        self.screen = screen
        
        children = []
    }

    // MARK: - Methods -
    func start() {
        let interactor = DiscoverInteractor()
        let presenter = DiscoverPresenter(interactor: interactor, coordinator: self, screen: screen)
        let viewController = DiscoverViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = viewController

        navigationController.setViewControllers([viewController], animated: false)
    }
}

// PRESENTER -> COORDINATOR
extension DiscoverCoordinator: DiscoverCoordinatorInput {
    func createItemList() {
        let coodinator = ItemListCoordinator(navigationController: navigationController)
        children.append(coodinator)
        coodinator.start()
    }
    
    func startItemListCoordinator(viewController: DiscoverViewController, for cell: DiscoverCell, at indexPath: IndexPath, with items: [Item]) {
        guard let coordinator = children[indexPath.row] as? ItemListCoordinator else { return }
        
        coordinator.show(viewController: viewController, for: cell)
        updateItemListCoordinator(at: indexPath, with: items)
    }
    
    func stopItemListCoordinator(at indexPath: IndexPath) {
        guard let coordinator = children[indexPath.row] as? ItemListCoordinator else { return }
        
        coordinator.stop()
    }
    
    func updateItemListCoordinator(at indexPath: IndexPath, with items: [Item]) {
        guard let coordinator = children[indexPath.row] as? ItemListCoordinator else { return }
        
        coordinator.update(with: items)
    }
    
    func showDetailsOf(id: Int, type: Item.ContentType) {
        let coodinator = DetailsCoordinator(navigationController: navigationController, id: id, type: type)
        children.append(coodinator)
        coodinator.start()
    }
}
