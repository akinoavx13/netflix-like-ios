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

    private var highestRatedMovie: Movie?
    
    // MARK: - Lifecycle -
    init(interactor: DiscoverInteractorInput, coordinator: DiscoverCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
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
        interactor.perform(Discover.Request.FetchHighestRatedMovies(page: 1))
        
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
        guard let highestRatedMovie = highestRatedMovie else { return }
        
        coordinator?.showHighestRatedMovieDetails(id: highestRatedMovie.id)
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
        self.highestRatedMovie = highestRatedMovie
        
        output?.display(Discover.DisplayData.HighestRatedMovie(movie: highestRatedMovie))
    }
    
    func present(_ response: Discover.Response.Error) {
        output?.display(Discover.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
