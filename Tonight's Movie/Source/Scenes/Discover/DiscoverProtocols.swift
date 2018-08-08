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
    func createItemList(section: ItemList.Section)
    func startItemListCoordinator(viewController: DiscoverViewController, for cell: DiscoverCell, at indexPath: IndexPath)
    func stopItemListCoordinator(at indexPath: IndexPath)
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol DiscoverInteractorInput {
    func perform(_ request: Discover.Request.FetchHighestRatedMovies)
}

// INTERACTOR -> PRESENTER (indirect)
protocol DiscoverInteractorOutput: class {
    func present(_ response: Discover.Response.HighestRatedMoviesFetched)
    func present(_ response: Discover.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol DiscoverPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int { get }
    
    // MARK: - Methods -
    func viewCreated()
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath)
    func willDisplay(viewController: DiscoverViewController, for cell: DiscoverCell, at indexPath: IndexPath)
    func didEndDisplaying(at indexPath: IndexPath)
}

// PRESENTER -> VIEW
protocol DiscoverPresenterOutput: class {
    func display(_ displayModel: Discover.DisplayData.HighestRatedMovie)
    func display(_ displayModel: Discover.DisplayData.Error)
}
