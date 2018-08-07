//
//  DiscoverProtocols.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
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
    func perform(_ request: Discover.Request.FetchPlayingMovies)
    func perform(_ request: Discover.Request.FetchOnTheAirTVShows)
}

// INTERACTOR -> PRESENTER (indirect)
protocol DiscoverInteractorOutput: class {
    func present(_ response: Discover.Response.PlayingMoviesFetched)
    func present(_ response: Discover.Response.OnTheAirTVShowsFetched)
    func present(_ response: Discover.Response.Error)
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
