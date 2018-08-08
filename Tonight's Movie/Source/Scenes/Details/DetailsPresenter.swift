//
//  DetailsPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class DetailsPresenter {
    
    // MARK: - Properties -
    let interactor: DetailsInteractorInput
    weak var coordinator: DetailsCoordinatorInput?
    weak var output: DetailsPresenterOutput?

    private let movieId: Int
    
    // MARK: - Lifecycle -
    init(interactor: DetailsInteractorInput, coordinator: DetailsCoordinatorInput, movieId: Int) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.movieId = movieId
    }
}

// MARK: - User Events -

extension DetailsPresenter: DetailsPresenterInput {
    func viewCreated() {
        interactor.perform(Details.Request.FetchMovieDetails(id: movieId))
    }
    
    func closeButtonTapped() {
        coordinator?.dismiss()
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DetailsPresenter: DetailsInteractorOutput {
    func present(_ response: Details.Response.MovieDetailsFetched) {
        output?.display(Details.DisplayData.MovieDetails(movie: response.movie))
    }
    
    func present(_ response: Details.Response.Error) {
        output?.display(Details.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
