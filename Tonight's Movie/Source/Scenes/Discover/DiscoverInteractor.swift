//
//  DiscoverInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class DiscoverInteractor {
    
    // MARK: - Properties -
    weak var output: DiscoverInteractorOutput?
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension DiscoverInteractor: DiscoverInteractorInput {
}
