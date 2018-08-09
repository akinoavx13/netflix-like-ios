//
//  DiscoverInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
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
    
    func perform(_ request: Discover.Request.FetchMostPopularMovies) {
        let request = dependencies
            .repository
            .getPopularMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Discover.Response.MostPopularMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }
    
    func perform(_ request: Discover.Request.FetchMostPopularTVShows) {
        let request = dependencies
            .repository
            .getMostPopularTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(Discover.Response.MostPopularTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverTVShows, request: request)
    }
    
    func cancel(_ request: Discover.Cancel.Requests) {        
        switch request.screen {
        case .Movies:
            dependencies
                .requestsManager
                .cancelRequests(of: .DiscoverMovies)
        case .TVShows:
            dependencies
                .requestsManager
                .cancelRequests(of: .DiscoverTVShows)
        }
    }
}
