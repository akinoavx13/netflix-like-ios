//
//  DiscoverCoordinator.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
        
        coordinator.show(viewController: viewController, into: cell.contenairView)
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
