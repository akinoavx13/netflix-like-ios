//
//  SearchInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class SearchInteractor {
    
    // MARK: - Properties -
    weak var output: SearchInteractorOutput?
    
    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension SearchInteractor: SearchInteractorInput {
    
    func perform(_ request: Search.Request.SearchMovies) {
        dependencies
            .repository
            .searchMovies(page: request.page, query: request.query) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Search.Response.MoviesFound(movies: movies))
                case .failure(let error):
                    self.output?.present(Search.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
}
