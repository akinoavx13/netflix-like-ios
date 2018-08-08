//
//  DetailsProtocols.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol DetailsCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol DetailsCoordinatorInput: class {
    func dismiss()
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol DetailsInteractorInput {
    func perform(_ request: Details.Request.FetchMovieDetails)
}

// INTERACTOR -> PRESENTER (indirect)
protocol DetailsInteractorOutput: class {
    func present(_ response: Details.Response.MovieDetailsFetched)
    func present(_ response: Details.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol DetailsPresenterInput {
    func viewCreated()
    func closeButtonTapped()
}

// PRESENTER -> VIEW
protocol DetailsPresenterOutput: class {
    func display(_ displayModel: Details.DisplayData.MovieDetails)
    func display(_ displayModel: Details.DisplayData.Error)
}