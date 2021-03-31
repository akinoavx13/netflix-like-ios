//
//  ItemListProtocols.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol ItemListCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol ItemListCoordinatorInput: class {
    func showDetailsOf(id: Int, of type: Item.ContentType)
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol ItemListInteractorInput {
    
}

// INTERACTOR -> PRESENTER (indirect)
protocol ItemListInteractorOutput: class {
    
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol ItemListPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int { get }
    
    // MARK: - Methods -
    func viewCreated()
    func configure(_ cell: ItemListCellProtocol, at indexPath: IndexPath)
    func didEndDisplaying(_ cell: ItemListCellProtocol)
    func showDetails(at indexPath: IndexPath)
}

// PRESENTER -> VIEW
protocol ItemListPresenterOutput: class {
    func display(_ displayModel: ItemList.DisplayData.Items)
}
