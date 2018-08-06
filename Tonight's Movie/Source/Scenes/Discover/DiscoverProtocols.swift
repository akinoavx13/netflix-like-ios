//
//  DiscoverProtocols.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol DiscoverCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol DiscoverCoordinatorInput: class {

}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol DiscoverInteractorInput {
    // func perform(_ request: Discover.Request.Work)
}

// INTERACTOR -> PRESENTER (indirect)
protocol DiscoverInteractorOutput: class {
    // func present(_ response: Discover.Response.Work)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol DiscoverPresenterInput {
    func viewCreated()
}

// PRESENTER -> VIEW
protocol DiscoverPresenterOutput: class {
    // func display(_ displayModel: Discover.DisplayData.Work)
}
