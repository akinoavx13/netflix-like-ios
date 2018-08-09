//
//  BookmarksInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class BookmarksInteractor {
    
    // MARK: - Properties -
    weak var output: BookmarksInteractorOutput?

    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension BookmarksInteractor: BookmarksInteractorInput {
    
    func perform(_ request: Bookmarks.Request.FetchSavedItems) {
        let items = dependencies
            .localManager
            .getItems()
        
        self.output?.present(Bookmarks.Response.SavedItemsFetched(items: items))
    }
    
    func perform(_ request: Bookmarks.Request.FetchRecommendationsMovies) {
        let request = dependencies
            .repository
            .getRecommendationsMovies(page: request.page, id: request.id) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Bookmarks.Response.RecommendationsMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Bookmarks.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .Bookmarks, request: request)
    }
    
    func perform(_ request: Bookmarks.Request.FetchRecommendationsTVShows) {
        let request = dependencies
            .repository
            .getRecommendationsTVShows(page: request.page, id: request.id) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(Bookmarks.Response.RecommendationsTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(Bookmarks.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .Bookmarks, request: request)
    }
    
    func cancel(_ request: Bookmarks.Cancel.Requests) {
        dependencies
            .requestsManager
            .cancelRequests(of: .Bookmarks)
    }
    
}
