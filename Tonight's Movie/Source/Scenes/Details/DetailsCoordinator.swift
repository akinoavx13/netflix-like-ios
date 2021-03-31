//
//  DetailsCoordinator.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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

        navigationController.pushViewController(viewController, animated: true)
    }
}

// PRESENTER -> COORDINATOR
extension DetailsCoordinator: DetailsCoordinatorInput {    
    func showRecommendations(with viewController: UIViewController, into view: UIView, with items: [Item]) {
        let coodinator = ItemListCoordinator(navigationController: navigationController)
        children.append(coodinator)
        coodinator.start()
        
        coodinator.show(viewController: viewController, into: view)
        coodinator.update(with: items)
    }
}
