//
//  ItemListInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class ItemListInteractor {
    
    // MARK: - Properties -
    weak var output: ItemListInteractorOutput?
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension ItemListInteractor: ItemListInteractorInput {
}
