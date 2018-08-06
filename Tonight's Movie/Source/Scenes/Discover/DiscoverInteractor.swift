//
//  DiscoverInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class DiscoverInteractor {
    
    // MARK: - Properties -
    weak var output: DiscoverInteractorOutput?
    
    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension DiscoverInteractor: DiscoverInteractorInput {
    
    func perform(_ request: Discover.Request.FetchMovies) {
        dependencies
            .repository
            .getMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Discover.Response.MoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
            }
    }
    
    func cancel(_ request: Discover.Cancelable.FetchMovies) {
        dependencies
            .requestsManager
            .cancelFetchMoviesRequests()
    }
    
    func perform(_ request: Discover.Request.FetchTVShows) {
        dependencies
            .repository
            .getTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(Discover.Response.TVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
    func cancel(_ request: Discover.Cancelable.FetchTVShows) {
        dependencies
            .requestsManager
            .cancelFetchTVShowsRequests()
    }
    
}
