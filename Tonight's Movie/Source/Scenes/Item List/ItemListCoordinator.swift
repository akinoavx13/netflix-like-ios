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
    private let discoverViewController: DiscoverViewController
    private let discoverCell: DiscoverCell
    
    private var itemListViewController: ItemListViewController?
    private var section: ItemList.Section
    
    // MARK: - Lifecycle -
    init(navigationController: UINavigationController, discoverViewController: DiscoverViewController, discoverCell: DiscoverCell, section: ItemList.Section) {
        self.navigationController = navigationController
        self.discoverViewController = discoverViewController
        self.discoverCell = discoverCell
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

        guard let itemListViewController = itemListViewController else { return }
        
        discoverViewController.addChild(itemListViewController)
        itemListViewController.view.frame = discoverCell.contenairView.bounds
        discoverCell.contenairView.addSubview(itemListViewController.view)
        discoverViewController.didMove(toParent: itemListViewController)
        discoverCell.contenairView.layoutIfNeeded()
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

}
