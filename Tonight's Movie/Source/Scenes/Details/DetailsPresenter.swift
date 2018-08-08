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

    private let id: Int
    private let type: Item.ContentType
    
    // MARK: - Lifecycle -
    init(interactor: DetailsInteractorInput, coordinator: DetailsCoordinatorInput, id: Int, type: Item.ContentType) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.id = id
        self.type = type
    }
}

// MARK: - User Events -

extension DetailsPresenter: DetailsPresenterInput {
    func viewCreated() {
        switch type {
        case .Movie:
            interactor.perform(Details.Request.FetchMovieDetails(id: id))
        case .TVShow:
            interactor.perform(Details.Request.FetchTVShowDetails(id: id))
        }
    }
    
    func closeButtonTapped() {
        coordinator?.dismiss()
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DetailsPresenter: DetailsInteractorOutput {
    func present(_ response: Details.Response.MovieDetailsFetched) {
        output?.display(Details.DisplayData.Details(
            pictureURL: response.movie.smallPictureUrl,
            backgroundURL: response.movie.smallBackgroundUrl,
            mark: response.movie.voteAverage,
            date: response.movie.formattedDate,
            duration: response.movie.duration,
            overview: response.movie.overview
        ))
    }
    
    func present(_ response: Details.Response.TVShowDetailsFetched) {
        output?.display(Details.DisplayData.Details(
            pictureURL: response.tvShow.smallPictureUrl,
            backgroundURL: response.tvShow.smallbackgroundUrl,
            mark: response.tvShow.voteAverage,
            date: response.tvShow.formattedDate,
            duration: response.tvShow.duration,
            overview: response.tvShow.overview
        ))
    }
    
    func present(_ response: Details.Response.Error) {
        output?.display(Details.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
