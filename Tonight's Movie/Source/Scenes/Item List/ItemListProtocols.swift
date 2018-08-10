//
//  ItemListProtocols.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
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
