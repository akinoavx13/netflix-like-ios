//
//  SearchProtocols.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

// ======== Coordinator ======== //

//protocol SearchCoordinatorDelegate: class {
//    func coordinator(_ coordinator: Coordinator, finishedWithSuccess success: Bool)
//}

// PRESENTER -> COORDINATOR
protocol SearchCoordinatorInput: class {

}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol SearchInteractorInput {
    func perform(_ request: Search.Request.SearchMovies)
}

// INTERACTOR -> PRESENTER (indirect)
protocol SearchInteractorOutput: class {
    func present(_ response: Search.Response.MoviesFound)
    func present(_ response: Search.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol SearchPresenterInput {
    
    // MARK: - Properties -
    var numberOfMovies: Int { get }
    
    // MARK: - Methods -
    func viewCreated()
    func search(with query: String)
    func configure(item: ItemListCellProtocol, at indexPath: IndexPath)
    func didEndDisplaying(item: ItemListCellProtocol, at indexPath: IndexPath)
    func displayEmptyState()
}

// PRESENTER -> VIEW
protocol SearchPresenterOutput: class {
    func display(_ displayModel: Search.DisplayData.Movies)
    func display(_ displayModel: Search.DisplayData.Error)
}
