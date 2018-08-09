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
        switch screen {
        case .Movies:
            return 4
        case .TVShows:
            return 3
        }
    }
    
    // MARK: - Methods -
    func viewCreated() {
        switch screen {
        case .Movies:
            interactor.perform(Discover.Request.FetchMostPopularMovies(page: 1))
        case .TVShows:
            interactor.perform(Discover.Request.FetchMostPopularTVShows(page: 1))
        }
        
        addCoordinators()
    }
    
    func viewWillDisappear() {
        interactor.cancel(Discover.Cancel.Requests(screen: screen))
    }
    
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath) {
        switch screen {
        case .Movies:
            if indexPath.row == 0 {
                item.display(title: Translation.Discover.currently)
            } else if indexPath.row == 1 {
                item.display(title: Translation.Discover.upcoming)
            } else if indexPath.row == 2 {
                item.display(title: Translation.Discover.popular)
            } else if indexPath.row == 3 {
                item.display(title: Translation.Discover.topRated)
            }
        case .TVShows:
            if indexPath.row == 0 {
                item.display(title: Translation.Discover.currently)
            } else if indexPath.row == 1 {
                item.display(title: Translation.Discover.popular)
            } else if indexPath.row == 2 {
                item.display(title: Translation.Discover.topRated)
            }
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
        
        switch screen {
        case .Movies:
            coordinator?.showHighestRatedItemDetails(id: highestRatedItemId, type: .Movie)
        case .TVShows:
            coordinator?.showHighestRatedItemDetails(id: highestRatedItemId, type: .TVShow)
        }
    }
    
    private func addCoordinators() {
        switch screen {
        case .Movies:
            coordinator?.createItemList(section: .Currently, screen: .Movies)
            coordinator?.createItemList(section: .Upcoming, screen: .Movies)
            coordinator?.createItemList(section: .Popular, screen: .Movies)
            coordinator?.createItemList(section: .TopRated, screen: .Movies)
        case .TVShows:
            coordinator?.createItemList(section: .Currently, screen: .TVShows)
            coordinator?.createItemList(section: .Popular, screen: .TVShows)
            coordinator?.createItemList(section: .TopRated, screen: .TVShows)
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DiscoverPresenter: DiscoverInteractorOutput {
    func present(_ response: Discover.Response.MostPopularMoviesFetched) {
        guard let highestRatedMovie = response.movies.first else { return }
        highestRatedItemId = highestRatedMovie.id
        
        output?.display(Discover.DisplayData.ForwardedItem(pictureURL: highestRatedMovie.originalPictureUrl))
    }
    
    func present(_ response: Discover.Response.MostPopularTVShowsFetched) {
        guard let highestRatedTVShow = response.tvShows.first else { return }
        highestRatedItemId = highestRatedTVShow.id
        
        output?.display(Discover.DisplayData.ForwardedItem(pictureURL: highestRatedTVShow.originalPictureUrl))
    }
    
    func present(_ response: Discover.Response.Error) {
        output?.display(Discover.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
