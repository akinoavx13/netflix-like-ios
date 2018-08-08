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
    func showDetailsOf(movieId: Int)
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol ItemListInteractorInput {
    func perform(_ request: ItemList.Request.FetchNowPlayingMovies)
    func perform(_ request: ItemList.Request.FetchUpcomingMovies)
    func perform(_ request: ItemList.Request.FetchPopularMovies)
    func perform(_ request: ItemList.Request.FetchTopRatedMovies)
    
    func perform(_ request: ItemList.Request.FetchOnTheAirTVShows)
}

// INTERACTOR -> PRESENTER (indirect)
protocol ItemListInteractorOutput: class {
    func present(_ response: ItemList.Response.NowPlayingMoviesFetched)
    func present(_ response: ItemList.Response.UpcomingMoviesFetched)
    func present(_ response: ItemList.Response.PopularMoviesFetched)
    func present(_ response: ItemList.Response.TopRatedMoviesFetched)
    
    func present(_ response: ItemList.Response.OnTheAirTVShowsFetched)
    
    func present(_ response: ItemList.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol ItemListPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int { get }
    
    // MARK: - Methods -
    func viewCreated()
    func configure(item: ItemListCellProtocol, at indexPath: IndexPath)
    func didEndDisplaying(item: ItemListCellProtocol, at indexPath: IndexPath)
    func displayNext()
    func showDetails(at indexPath: IndexPath)
}

// PRESENTER -> VIEW
protocol ItemListPresenterOutput: class {
    func display(_ displayModel: ItemList.DisplayData.Items)
    func display(_ displayModel: ItemList.DisplayData.Error)
}
