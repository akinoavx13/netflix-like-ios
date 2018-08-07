//
//  DiscoverPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class DiscoverPresenter {
    
    // MARK: - Properties -
    let interactor: DiscoverInteractorInput
    weak var coordinator: DiscoverCoordinatorInput?
    weak var output: DiscoverPresenterOutput?

    
    // MARK: - Lifecycle -
    init(interactor: DiscoverInteractorInput, coordinator: DiscoverCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension DiscoverPresenter: DiscoverPresenterInput {
    func viewCreated() {
        interactor.perform(Discover.Request.FetchPlayingMovies(page: 1))
        interactor.perform(Discover.Request.FetchOnTheAirTVShows(page: 1))
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DiscoverPresenter: DiscoverInteractorOutput {
    func present(_ response: Discover.Response.PlayingMoviesFetched) {
        
    }
    
    func present(_ response: Discover.Response.OnTheAirTVShowsFetched) {
        
    }
    
    func present(_ response: Discover.Response.Error) {
        
    }
}
