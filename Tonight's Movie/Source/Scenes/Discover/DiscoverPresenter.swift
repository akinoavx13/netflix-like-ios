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

    // MARK: - Lifecycle -
    init(interactor: DiscoverInteractorInput, coordinator: DiscoverCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension DiscoverPresenter: DiscoverPresenterInput {
    func viewCreated() {
        interactor.perform(Discover.Request.FetchPopularTVShows(page: 1))
    }
    
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath) {
        if indexPath.row == 0 {
            item.display(title: Translation.Discover.currently)
        } else if indexPath.row == 1 {
            item.display(title: Translation.Discover.upcoming)
        } else if indexPath.row == 2 {
            item.display(title: Translation.Discover.lastly)
        } else if indexPath.row == 3 {
            item.display(title: Translation.Discover.popular)
        } else if indexPath.row == 4 {
            item.display(title: Translation.Discover.topRated)
        }
    }
    
    func willDisplay(item: DiscoverCell, viewController: DiscoverViewController) {
        coordinator?.showItemList(discoverViewController: viewController, discoverCell: item)
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DiscoverPresenter: DiscoverInteractorOutput {
    func present(_ response: Discover.Response.PopularTVShowsFetched) {
        guard let forwardTvShow = response.tvShows.shuffled().first else { return}
        
        output?.display(Discover.DisplayData.ForwardTVShow(tvShow: forwardTvShow))
    }
    
    func present(_ response: Discover.Response.Error) {
        output?.display(Discover.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
