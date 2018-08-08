//
//  ItemListCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

class ItemListCoordinator: Coordinator {
    
    // MARK: - Properties -
    var children: [Coordinator]

    private let navigationController: UINavigationController
    
    private var itemListViewController: ItemListViewController?
    private var section: ItemList.Section
    
    // MARK: - Lifecycle -
    init(navigationController: UINavigationController, section: ItemList.Section) {
        self.navigationController = navigationController
        self.section = section
        
        children = []
    }
    
    // MARK: - Methods -
    func start() {
        let interactor = ItemListInteractor()
        let presenter = ItemListPresenter(interactor: interactor, coordinator: self, section: section)
        itemListViewController = ItemListViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = itemListViewController
    }
    
    func show(viewController: DiscoverViewController, for cell: DiscoverCell) {
        guard let itemListViewController = itemListViewController else { return }

        viewController.addChild(itemListViewController)
        itemListViewController.view.frame = cell.contenairView.bounds
        cell.contenairView.addSubview(itemListViewController.view)
        viewController.didMove(toParent: itemListViewController)
        cell.contenairView.layoutIfNeeded()
    }
    
    func stop() {
        guard let itemListViewController = itemListViewController else { return }
        
        itemListViewController.view.removeFromSuperview()
        itemListViewController.willMove(toParent: nil)
        itemListViewController.removeFromParent()
    }
}

// PRESENTER -> COORDINATOR
extension ItemListCoordinator: ItemListCoordinatorInput {
    func showDetailsOf(movieId: Int) {
        let coordinator = DetailsCoordinator(navigationController: navigationController, movieId: movieId)
        children = [coordinator]
        coordinator.start()
    }
}
