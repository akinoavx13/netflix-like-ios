//
//  DiscoverProtocols.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol DiscoverCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol DiscoverCoordinatorInput: class {
    func createItemList()
    func startItemListCoordinator(viewController: DiscoverViewController, for cell: DiscoverCell, at indexPath: IndexPath, with items: [Item])
    func stopItemListCoordinator(at indexPath: IndexPath)
    func updateItemListCoordinator(at indexPath: IndexPath, with items: [Item])
    func showDetailsOf(id: Int, type: Item.ContentType)
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol DiscoverInteractorInput {
    // MARK: - Movies -
    func perform(_ request: Discover.Request.FetchMostPopularMovies)
    func perform(_ request: Discover.Request.FetchNowPlayingMovies)
    func perform(_ request: Discover.Request.FetchPopularMovies)
    func perform(_ request: Discover.Request.FetchTopRatedMovies)
    func perform(_ request: Discover.Request.FetchUpcomingMovies)
    
    // MARK: - Movies -
    func perform(_ request: Discover.Request.FetchMostPopularTVShows)
    func perform(_ request: Discover.Request.FetchOnTheAirTVShows)
    func perform(_ request: Discover.Request.FetchPopularTVShows)
    func perform(_ request: Discover.Request.FetchTopRatedTVShows)
    
    // MARK: - Cancel -
    func cancel(_ request: Discover.Cancel.Requests)
}

// INTERACTOR -> PRESENTER (indirect)
protocol DiscoverInteractorOutput: class {
    // MARK: - Movies -
    func present(_ response: Discover.Response.MostPopularMoviesFetched)
    func present(_ response: Discover.Response.NowPlayingMoviesFetched)
    func present(_ response: Discover.Response.PopularMoviesFetched)
    func present(_ response: Discover.Response.TopRatedMoviesFetched)
    func present(_ response: Discover.Response.UpcomingMoviesFetched)
    
    // MARK: - TVShows -
    func present(_ response: Discover.Response.MostPopularTVShowsFetched)
    func present(_ response: Discover.Response.OnTheAirTVShowsFetched)
    func present(_ response: Discover.Response.PopularTVShowsFetched)
    func present(_ response: Discover.Response.TopRatedTVShowsFetched)
    
    // MARK: - Error -
    func present(_ response: Discover.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol DiscoverPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int { get }
    
    // MARK: - Methods -
    func viewCreated()
    func viewWillDisappear()
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath)
    func willDisplay(viewController: DiscoverViewController, for cell: DiscoverCell, at indexPath: IndexPath)
    func didEndDisplaying(at indexPath: IndexPath)
    func showForwardedItemDetails()
    func fetchNextItems(at indexPath: IndexPath)
}

// PRESENTER -> VIEW
protocol DiscoverPresenterOutput: class {
    func display(_ displayModel: Discover.DisplayData.ForwardedItem)
    
    func display(_ displayModel: Discover.DisplayData.Error)
}
