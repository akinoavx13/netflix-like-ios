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
    func perform(_ request: Discover.Request.FetchMovies)
    func perform(_ request: Discover.Request.FetchTVShows)
    func cancel(_ request: Discover.Cancelable.FetchMovies)
    func cancel(_ request: Discover.Cancelable.FetchTVShows)
}

// INTERACTOR -> PRESENTER (indirect)
protocol DiscoverInteractorOutput: class {
    func present(_ response: Discover.Response.MoviesFetched)
    func present(_ response: Discover.Response.TVShowsFetched)
    func present(_ response: Discover.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol DiscoverPresenterInput {
    
    // MARK: - Properties -
    var numberOfMovies: Int { get }
    var numberOfTVShows: Int { get }
    
    // MARK: - Methods -
    func viewCreated()
    func viewWillDisappear()
    func displayMoviesAndShows()
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath)
    func configure(item: DiscoverHeaderViewProtocol, at indexPath: IndexPath)
    func configure(item: DiscoverFooterViewProtocol, at indexPath: IndexPath)
}

// PRESENTER -> VIEW
protocol DiscoverPresenterOutput: class {
    func display(_ displayModel: Discover.DisplayData.Movies)
    func display(_ displayModel: Discover.DisplayData.TVShows)
    func display(_ displayModel: Discover.DisplayData.Error)
}
