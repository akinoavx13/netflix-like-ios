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
        dependencies
            .repository
            .getNowPlayingMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(ItemList.Response.NowPlayingMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
    func perform(_ request: ItemList.Request.FetchUpcomingMovies) {
        dependencies
            .repository
            .getUpcomingMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(ItemList.Response.UpcomingMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
    func perform(_ request: ItemList.Request.FetchPopularMovies) {
        dependencies
            .repository
            .getPopularMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(ItemList.Response.PopularMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
    func perform(_ request: ItemList.Request.FetchTopRatedMovies) {
        dependencies
            .repository
            .getTopRatedMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(ItemList.Response.TopRatedMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }

    // MARK: - TVShows -
    func perform(_ request: ItemList.Request.FetchOnTheAirTVShows) {
        dependencies
            .repository
            .getOnTheAirTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(ItemList.Response.OnTheAirTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(ItemList.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
}
