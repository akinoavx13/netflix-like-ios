//
//  BookmarksInteractor.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class BookmarksInteractor {
    
    // MARK: - Properties -
    weak var output: BookmarksInteractorOutput?

    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension BookmarksInteractor: BookmarksInteractorInput {
    
    func perform(_ request: Bookmarks.Request.FetchSavedItems) {
        let items = dependencies
            .localManager
            .getItems()
        
        self.output?.present(Bookmarks.Response.SavedItemsFetched(items: items))
    }
    
}
