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

    // MARK: - Lifecycle -
    init(interactor: DetailsInteractorInput, coordinator: DetailsCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension DetailsPresenter: DetailsPresenterInput {
    func viewCreated() {

    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DetailsPresenter: DetailsInteractorOutput {

}
