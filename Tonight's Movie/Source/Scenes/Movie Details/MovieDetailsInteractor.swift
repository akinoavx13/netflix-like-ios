//
//  MovieDetailsInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class MovieDetailsInteractor {
    
    // MARK: - Properties -
    weak var output: MovieDetailsInteractorOutput?
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension MovieDetailsInteractor: MovieDetailsInteractorInput {
}
