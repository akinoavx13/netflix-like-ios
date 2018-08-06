//
//  DetailsPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class DetailsPresenter {
    
    // MARK: - Properties -
    private let interactor: DetailsInteractorInput
    private weak var coordinator: DetailsCoordinatorInput?
    weak var output: DetailsPresenterOutput?

    private let id: Int
    private let type: Details.ContentType
    
    // MARK: - Lifecycle -
    init(interactor: DetailsInteractorInput, coordinator: DetailsCoordinatorInput, type: Details.ContentType, id: Int) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.type = type
        self.id = id
    }
}

// MARK: - User Events -

extension DetailsPresenter: DetailsPresenterInput {
    func viewCreated() {
        switch type {
        case .Movie:
            interactor.perform(Details.Request.FetchMovie(id: id))
        case .TVShow:
            interactor.perform(Details.Request.FetchTVShow(id: id))
        }
    }
    
    func viewWillDisappear() {
        interactor.cancel(Details.Cancelable.FetchMovies())
        interactor.cancel(Details.Cancelable.FetchTVShows())
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DetailsPresenter: DetailsInteractorOutput {
    func present(_ response: Details.Response.DetailsFetched) {
        output?.display(Details.DisplayData.DetailsFetched(
            title: response.title,
            backgroundURL: response.backgroundURL,
            pictureURL: response.pictureURL
        ))
    }
    
    func present(_ response: Details.Response.Error) {
        output?.display(Details.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
