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
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension SearchInteractor: SearchInteractorInput {
}
