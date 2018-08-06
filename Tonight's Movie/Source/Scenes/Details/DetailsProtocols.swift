//
//  DetailsProtocols.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
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

}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol DetailsInteractorInput {
    func perform(_ request: Details.Request.FetchMovie)
    func perform(_ request: Details.Request.FetchTVShow)
    func cancel(_ request: Details.Cancelable.FetchMovies)
    func cancel(_ request: Details.Cancelable.FetchTVShows)
}

// INTERACTOR -> PRESENTER (indirect)
protocol DetailsInteractorOutput: class {
    func present(_ response: Details.Response.DetailsFetched)
    func present(_ response: Details.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol DetailsPresenterInput {
    func viewCreated()
    func viewWillDisappear()
}

// PRESENTER -> VIEW
protocol DetailsPresenterOutput: class {
    func display(_ displayModel: Details.DisplayData.DetailsFetched)
    func display(_ displayModel: Details.DisplayData.Error)
}
