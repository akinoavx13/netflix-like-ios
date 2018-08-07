//
//  ItemListPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class ItemListPresenter {
    
    // MARK: - Properties -
    let interactor: ItemListInteractorInput
    weak var coordinator: ItemListCoordinatorInput?
    weak var output: ItemListPresenterOutput?

    // MARK: - Lifecycle -
    init(interactor: ItemListInteractorInput, coordinator: ItemListCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension ItemListPresenter: ItemListPresenterInput {
    func viewCreated() {

    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension ItemListPresenter: ItemListInteractorOutput {

}
