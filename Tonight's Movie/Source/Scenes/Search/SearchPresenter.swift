//
//  SearchPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class SearchPresenter {
    
    // MARK: - Properties -
    let interactor: SearchInteractorInput
    weak var coordinator: SearchCoordinatorInput?
    weak var output: SearchPresenterOutput?

    // MARK: - Lifecycle -
    init(interactor: SearchInteractorInput, coordinator: SearchCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension SearchPresenter: SearchPresenterInput {
    func viewCreated() {

    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension SearchPresenter: SearchInteractorOutput {

}
