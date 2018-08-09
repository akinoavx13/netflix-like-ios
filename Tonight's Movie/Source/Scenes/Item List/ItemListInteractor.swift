//
//  ItemListInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class ItemListInteractor {
    
    // MARK: - Properties -
    weak var output: ItemListInteractorOutput?
    
    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension ItemListInteractor: ItemListInteractorInput {
    
    // MARK: - Movies -
    func perform(_ request: ItemList.Request.FetchNowPlayingMovies) {        
        let request = dependencies
            .repository
            .getNowPlayingMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(ItemList.Response.NowPlayingMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }
    
    func perform(_ request: ItemList.Request.FetchUpcomingMovies) {
        let request = dependencies
            .repository
            .getUpcomingMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(ItemList.Response.UpcomingMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }
    
    func perform(_ request: ItemList.Request.FetchPopularMovies) {
        let request = dependencies
            .repository
            .getPopularMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(ItemList.Response.PopularMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }
    
    func perform(_ request: ItemList.Request.FetchTopRatedMovies) {
        let request = dependencies
            .repository
            .getTopRatedMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(ItemList.Response.TopRatedMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }

    // MARK: - TVShows -
    func perform(_ request: ItemList.Request.FetchOnTheAirTVShows) {
        let request = dependencies
            .repository
            .getOnTheAirTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(ItemList.Response.OnTheAirTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverTVShows, request: request)
    }
    
    func perform(_ request: ItemList.Request.FetchPopularTVShows) {
        let request = dependencies
            .repository
            .getPopularTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(ItemList.Response.PopularTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverTVShows, request: request)
    }
    
    func perform(_ request: ItemList.Request.FetchTopRatedTVShows) {
        let request = dependencies
            .repository
            .getTopRatedTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(ItemList.Response.TopRatedTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverTVShows, request: request)
    }
    
    func cancel(_ request: ItemList.Cancel.Requests) {
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
