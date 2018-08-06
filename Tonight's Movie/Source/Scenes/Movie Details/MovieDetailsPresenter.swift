//
//  MovieDetailsPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class MovieDetailsPresenter {
    
    // MARK: - Properties -
    let interactor: MovieDetailsInteractorInput
    weak var coordinator: MovieDetailsCoordinatorInput?
    weak var output: MovieDetailsPresenterOutput?

    // MARK: - Lifecycle -
    init(interactor: MovieDetailsInteractorInput, coordinator: MovieDetailsCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension MovieDetailsPresenter: MovieDetailsPresenterInput {
    func viewCreated() {

    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension MovieDetailsPresenter: MovieDetailsInteractorOutput {

}
