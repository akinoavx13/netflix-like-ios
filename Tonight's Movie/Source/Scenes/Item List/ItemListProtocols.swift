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

}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol ItemListInteractorInput {
    // func perform(_ request: ItemList.Request.Work)
}

// INTERACTOR -> PRESENTER (indirect)
protocol ItemListInteractorOutput: class {
    // func present(_ response: ItemList.Response.Work)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol ItemListPresenterInput {
    func viewCreated()
}

// PRESENTER -> VIEW
protocol ItemListPresenterOutput: class {
    // func display(_ displayModel: ItemList.DisplayData.Work)
}
