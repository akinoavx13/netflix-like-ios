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
    func perform(_ request: Details.Request.FetchTVShowDetails)
    func perform(_ request: Details.Request.SaveItem)
    func perform(_ request: Details.Request.FetchIsItemSaved)
    func perform(_ request: Details.Request.RemoveItem)
    func perform(_ request: Details.Request.FetchMovieVideos)
    func perform(_ request: Details.Request.FetchTVShowVideos)
    
    func cancel(_ request: Details.Cancel.Requests)
}

// INTERACTOR -> PRESENTER (indirect)
protocol DetailsInteractorOutput: class {
    func present(_ response: Details.Response.MovieDetailsFetched)
    func present(_ response: Details.Response.TVShowDetailsFetched)
    func present(_ response: Details.Response.IsItemSavedFetch)
    func present(_ response: Details.Response.VideosFetched)
    
    func present(_ response: Details.Response.Error)
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol DetailsPresenterInput {
    func viewCreated()
    func viewWillDisappear()
    func closeButtonTapped()
    func addButtonTapped()
}

// PRESENTER -> VIEW
protocol DetailsPresenterOutput: class {
    func display(_ displayModel: Details.DisplayData.Details)
    func display(_ displayModel: Details.DisplayData.IsItemSaved)
    func display(_ displayModel: Details.DisplayData.Trailer)
    
    func display(_ displayModel: Details.DisplayData.Error)
}
