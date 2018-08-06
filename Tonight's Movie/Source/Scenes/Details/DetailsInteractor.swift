//
//  DetailsInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class DetailsInteractor {
    
    // MARK: - Properties -
    weak var output: DetailsInteractorOutput?
    
    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension DetailsInteractor: DetailsInteractorInput {
    func perform(_ request: Details.Request.FetchMovie) {
        dependencies
            .repository
            .getMovie(id: request.id) { (result) in
                switch result {
                case .success(let movie):
                    self.output?.present(Details.Response.DetailsFetched(
                        title: movie.title,
                        backgroundURL: movie.backgroundURL,
                        pictureURL: movie.pictureURL,
                        date: movie.date,
                        overview: movie.overview
                    ))
                case .failure(let error):
                    self.output?.present(Details.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
    func perform(_ request: Details.Request.FetchTVShow) {
        dependencies
            .repository
            .getTVShow(id: request.id) { (result) in
                switch result {
                case .success(let tvShow):
                    self.output?.present(Details.Response.DetailsFetched(
                        title: tvShow.name,
                        backgroundURL: tvShow.backgroundURL,
                        pictureURL: tvShow.pictureURL,
                        date: tvShow.date,
                        overview: tvShow.overview
                    ))
                case .failure(let error):
                    self.output?.present(Details.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
    func cancel(_ request: Details.Cancelable.FetchMovies) {
        dependencies
            .requestsManager
            .cancelFetchMovieRequests()
    }
    
    func cancel(_ request: Details.Cancelable.FetchTVShows) {
        dependencies
            .requestsManager
            .cancelFetchTVShowRequests()
    }
}
