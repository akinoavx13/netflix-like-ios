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
    
    func perform(_ request: Discover.Request.FetchHighestRatedMovies) {
        dependencies
            .repository
            .getHighestRatedMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Discover.Response.HighestRatedMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
    func perform(_ request: Discover.Request.FetchHighestRatedTVShow) {
        dependencies
            .repository
            .getHighestRatedTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(Discover.Response.HighestRatedTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
}
