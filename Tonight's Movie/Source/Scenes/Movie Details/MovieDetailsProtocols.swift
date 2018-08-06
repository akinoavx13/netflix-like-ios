//
//  MovieDetailsProtocols.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol MovieDetailsCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol MovieDetailsCoordinatorInput: class {

}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol MovieDetailsInteractorInput {
    // func perform(_ request: MovieDetails.Request.Work)
}

// INTERACTOR -> PRESENTER (indirect)
protocol MovieDetailsInteractorOutput: class {
    // func present(_ response: MovieDetails.Response.Work)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol MovieDetailsPresenterInput {
    func viewCreated()
}

// PRESENTER -> VIEW
protocol MovieDetailsPresenterOutput: class {
    // func display(_ displayModel: MovieDetails.DisplayData.Work)
}
