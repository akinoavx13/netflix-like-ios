//
//  ItemListCoordinator.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
    
    func show(viewController: UIViewController, into view: UIView) {
        guard let itemListViewController = itemListViewController else { return }

        itemListViewController.delegate = viewController as? ItemListViewControllerDelegate
        viewController.addChild(itemListViewController)
        itemListViewController.view.frame = view.bounds
        view.addSubview(itemListViewController.view)
        viewController.didMove(toParent: itemListViewController)
        view.layoutIfNeeded()
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
