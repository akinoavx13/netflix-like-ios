//
//  BookmarksPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class BookmarksPresenter {
    
    // MARK: - Properties -
    let interactor: BookmarksInteractorInput
    weak var coordinator: BookmarksCoordinatorInput?
    weak var output: BookmarksPresenterOutput?

    private var savedItems: [Item]
    
    // MARK: - Lifecycle -
    init(interactor: BookmarksInteractorInput, coordinator: BookmarksCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
        
        savedItems = []
    }
}

// MARK: - User Events -

extension BookmarksPresenter: BookmarksPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int {
        return savedItems.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        
    }
    
    func viewWillAppear() {
        interactor.perform(Bookmarks.Request.FetchSavedItems())
    }
    
    func configure(item: ItemListCellProtocol, at indexPath: IndexPath) {
        let savedItem = savedItems[indexPath.row]
        
        item.display(pictureURL: savedItem.pictureURL)
    }
    
    func configure(item: SearchHeaderViewProtocol, at indexPath: IndexPath) {
        if indexPath.section == 0 {
            item.display(title: Translation.Bookmarks.bookmarks)
        }
    }
    
    func didEndDisplaying(item: ItemListCellProtocol, at indexPath: IndexPath) {
        item.didEndDisplaying()
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension BookmarksPresenter: BookmarksInteractorOutput {
    func present(_ response: Bookmarks.Response.SavedItemsFetched) {
        savedItems = response.items
        output?.display(Bookmarks.DisplayData.Items())
    }
}
