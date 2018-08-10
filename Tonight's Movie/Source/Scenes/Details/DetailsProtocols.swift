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
    func showRecommendations(with viewController: UIViewController, into view: UIView, with items: [Item])
}

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol DetailsInteractorInput {
    // MARK: - Movies -
    func perform(_ request: Details.Request.FetchMovieDetails)
    func perform(_ request: Details.Request.FetchMovieRecommendations)
    
    // MARK: - TVShows -
    func perform(_ request: Details.Request.FetchTVShowDetails)
    
    // MARK: - Videos -
    func perform(_ request: Details.Request.FetchMovieVideos)
    func perform(_ request: Details.Request.FetchTVShowVideos)
    
    // MARK: - Local -
    func perform(_ request: Details.Request.SaveItem)
    func perform(_ request: Details.Request.FetchIsItemSaved)
    func perform(_ request: Details.Request.RemoveItem)
    
    // MARK: - Cancel -
    func cancel(_ request: Details.Cancel.Requests)
}

// INTERACTOR -> PRESENTER (indirect)
protocol DetailsInteractorOutput: class {
    // MARK: - Movies -
    func present(_ response: Details.Response.MovieDetailsFetched)
    func present(_ response: Details.Response.MovieRecommendationsFetched)
    
    // MARK: - TVShows -
    func present(_ response: Details.Response.TVShowDetailsFetched)
    
    // MARK: - Videos -
    func present(_ response: Details.Response.VideosFetched)
    
    // MARK: - Local -
    func present(_ response: Details.Response.IsItemSavedFetch)
    
    // MARK: - Cancel -
    func present(_ response: Details.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol DetailsPresenterInput {
    func viewCreated()
    func viewWillDisappear()
    func closeButtonTapped()
    func addButtonTapped()
    func showRecommendations(with viewController: UIViewController, into view: UIView)
}

// PRESENTER -> VIEW
protocol DetailsPresenterOutput: class {
    func display(_ displayModel: Details.DisplayData.Details)
    func display(_ displayModel: Details.DisplayData.IsItemSaved)
    func display(_ displayModel: Details.DisplayData.Trailer)
    func display(_ displayModel: Details.DisplayData.Recommendations)
    
    func display(_ displayModel: Details.DisplayData.Error)
}
