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
    
    func perform(_ request: Details.Request.FetchMovieDetails) {
        dependencies
            .repository
            .getMovieDetails(id: request.id) { (result) in
                switch result {
                case .success(let movie):
                    self.output?.present(Details.Response.MovieDetailsFetched(movie: movie))
                case .failure(let error):
                    self.output?.present(Details.Response.Error(errorMessage: error.localizedDescription))
                }
        }
    }
    
}
