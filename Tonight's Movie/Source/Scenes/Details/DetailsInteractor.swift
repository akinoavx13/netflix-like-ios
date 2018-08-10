//
//  DetailsInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
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
    
    // MARK: - Movies -
    func perform(_ request: Details.Request.FetchMovieDetails) {
        let request = dependencies
            .repository
            .getMovieDetails(id: request.id) { (result) in
                switch result {
                case .success(let movie):
                    self.output?.present(Details.Response.MovieDetailsFetched(movie: movie))
                case .failure(let error):
                    self.output?.present(Details.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .Details, request: request)
    }
    
    func perform(_ request: Details.Request.FetchMovieRecommendations) {
        let request = dependencies
            .repository
            .getRecommendationsMovies(page: request.page, id: request.id) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Details.Response.MovieRecommendationsFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Details.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .Details, request: request)
    }
    
    // MARK: - TVShows -
    func perform(_ request: Details.Request.FetchTVShowDetails) {
        let request = dependencies
            .repository
            .getTVShowDetails(id: request.id) { (result) in
                switch result {
                case .success(let tvShow):
                    self.output?.present(Details.Response.TVShowDetailsFetched(tvShow: tvShow))
                case .failure(let error):
                    self.output?.present(Details.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .Details, request: request)
    }
    
    // MARK: - Local -
    func perform(_ request: Details.Request.SaveItem) {
        dependencies
            .localManager
            .save(item: request.item)
    }
    
    func perform(_ request: Details.Request.FetchIsItemSaved) {
        let isSaved = dependencies
            .localManager
            .isPresent(item: request.item)
        
        self.output?.present(Details.Response.IsItemSavedFetch(isSaved: isSaved))
    }
    
    func perform(_ request: Details.Request.RemoveItem) {
        dependencies
            .localManager
            .remove(item: request.item)
    }
    
    // MARK: - Videos -
    func perform(_ request: Details.Request.FetchMovieVideos) {
        let request = dependencies
            .repository
            .getMovieVideos(id: request.id) { (result) in
                switch result {
                case .success(let videos):
                    self.output?.present(Details.Response.VideosFetched(videos: videos))
                case .failure(let error):
                    self.output?.present(Details.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .Details, request: request)
    }
    
    func perform(_ request: Details.Request.FetchTVShowVideos) {
        let request = dependencies
            .repository
            .getTVShowVideos(id: request.id) { (result) in
                switch result {
                case .success(let videos):
                    self.output?.present(Details.Response.VideosFetched(videos: videos))
                case .failure(let error):
                    self.output?.present(Details.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .Details, request: request)
    }
    
    // MARK: - Cancel -
    func cancel(_ request: Details.Cancel.Requests) {
        dependencies
            .requestsManager
            .cancelRequests(of: .Details)
    }
    
}
