//
//  DiscoverPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class DiscoverPresenter {
    
    // MARK: - Properties -
    let interactor: DiscoverInteractorInput
    weak var coordinator: DiscoverCoordinatorInput?
    weak var output: DiscoverPresenterOutput?

    private var highestRatedItemId: Int?
    private let screen: Discover.Screen

    // MARK: - Lifecycle -
    init(interactor: DiscoverInteractorInput, coordinator: DiscoverCoordinatorInput, screen: Discover.Screen) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.screen = screen
    }
}

// MARK: - User Events -

extension DiscoverPresenter: DiscoverPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int {
        return ItemList.Section.allCases.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        switch screen {
        case .Movies:
            interactor.perform(Discover.Request.FetchHighestRatedMovies(page: 1))
        case .TVshows:
            interactor.perform(Discover.Request.FetchHighestRatedTVShow(page: 1))
        }
        
        addCoordinators()
    }
    
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath) {
        if indexPath.row == 0 {
            item.display(title: Translation.Discover.currently)
        } else if indexPath.row == 1 {
            item.display(title: Translation.Discover.upcoming)
        } else if indexPath.row == 2 {
            item.display(title: Translation.Discover.popular)
        } else if indexPath.row == 3 {
            item.display(title: Translation.Discover.topRated)
        }
    }

    func willDisplay(viewController: DiscoverViewController, for cell: DiscoverCell, at indexPath: IndexPath) {
        coordinator?.startItemListCoordinator(viewController: viewController, for: cell, at: indexPath)
    }
    
    func didEndDisplaying(at indexPath: IndexPath) {
        coordinator?.stopItemListCoordinator(at: indexPath)
    }
    
    func showHighestRatedMovieDetails() {
        guard let highestRatedItemId = highestRatedItemId else { return }
        
        coordinator?.showHighestRatedMovieDetails(id: highestRatedItemId)
    }
    
    private func addCoordinators() {
        for section in ItemList.Section.allCases.enumerated() {
            coordinator?.createItemList(section: section.element)
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DiscoverPresenter: DiscoverInteractorOutput {
    func present(_ response: Discover.Response.HighestRatedMoviesFetched) {
        guard let highestRatedMovie = response.movies.first else { return }
        highestRatedItemId = highestRatedMovie.id
        
        output?.display(Discover.DisplayData.HighestRatedItem(pictureURL: highestRatedMovie.originalPictureUrl))
    }
    
    func present(_ response: Discover.Response.HighestRatedTVShowsFetched) {
        guard let highestRatedTVShow = response.tvShows.first else { return }
        highestRatedItemId = highestRatedTVShow.id
        
        output?.display(Discover.DisplayData.HighestRatedItem(pictureURL: highestRatedTVShow.originalPictureUrl))
    }
    
    func present(_ response: Discover.Response.Error) {
        output?.display(Discover.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
