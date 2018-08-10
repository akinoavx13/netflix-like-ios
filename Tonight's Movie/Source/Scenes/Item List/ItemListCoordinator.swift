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
    private var presenter: ItemListPresenter?
    
    // MARK: - Lifecycle -
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        children = []
    }
    
    // MARK: - Methods -
    func start() {
        let interactor = ItemListInteractor()
        presenter = ItemListPresenter(interactor: interactor, coordinator: self)
        
        guard let presenter = presenter else { return }
        
        itemListViewController = ItemListViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = itemListViewController
    }
    
    func show(viewController: DiscoverViewController, for cell: DiscoverCell) {
        guard let itemListViewController = itemListViewController else { return }

        itemListViewController.delegate = viewController
        viewController.addChild(itemListViewController)
        itemListViewController.view.frame = cell.contenairView.bounds
        cell.contenairView.addSubview(itemListViewController.view)
        viewController.didMove(toParent: itemListViewController)
        cell.contenairView.layoutIfNeeded()
    }
    
    func stop() {
        guard let itemListViewController = itemListViewController else { return }
        
        itemListViewController.delegate = nil
        itemListViewController.view.removeFromSuperview()
        itemListViewController.willMove(toParent: nil)
        itemListViewController.removeFromParent()
    }
    
    func update(with items: [Item]) {
        presenter?.update(items: items)
    }
}

// PRESENTER -> COORDINATOR
extension ItemListCoordinator: ItemListCoordinatorInput {
    func showDetailsOf(id: Int, of type: Item.ContentType) {
        let coordinator = DetailsCoordinator(navigationController: navigationController, id: id, type: type)
        children = [coordinator]
        coordinator.start()
    }
}
