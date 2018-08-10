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

    private var forwardedItemId: Int?
    private let screen: Discover.Screen
    
    private var nowPlayingItems: [Item]
    private var popularItems: [Item]
    private var topRatedItems: [Item]
    private var upcomingItems: [Item]

    private var nowPlayingPage: Int
    private var popularPage: Int
    private var topRatedPage: Int
    private var upcomingPage: Int
    
    // MARK: - Lifecycle -
    init(interactor: DiscoverInteractorInput, coordinator: DiscoverCoordinatorInput, screen: Discover.Screen) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.screen = screen
        
        nowPlayingItems = []
        popularItems = []
        topRatedItems = []
        upcomingItems = []
        
        nowPlayingPage = 1
        popularPage = 1
        topRatedPage = 1
        upcomingPage = 1
    }
}

// MARK: - User Events -

extension DiscoverPresenter: DiscoverPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int {
        switch screen {
        case .Movies:
            return Discover.Sections.Movies.allCases.count
        case .TVShows:
            return Discover.Sections.TVShows.allCases.count
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
        
        addSections()
    }
    
    func viewWillDisappear() {
        interactor.cancel(Discover.Cancel.Requests(screen: screen))
    }
    
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath) {
        switch screen {
        case .Movies:
            switch getMoviesSection(with: indexPath) {
            case .NowPlaying:
                item.display(title: Translation.Discover.currently)
            case .Popular:
                item.display(title: Translation.Discover.popular)
            case .TopRated:
                item.display(title: Translation.Discover.topRated)
            case .Upcoming:
                item.display(title: Translation.Discover.upcoming)
            }
        case .TVShows:
            switch getTVShowsSection(with: indexPath) {
            case .OnTheAir:
                item.display(title: Translation.Discover.currently)
            case .Popular:
                item.display(title: Translation.Discover.popular)
            case .TopRated:
                item.display(title: Translation.Discover.topRated)
            }
        }
    }

    func willDisplay(viewController: DiscoverViewController, for cell: DiscoverCell, at indexPath: IndexPath) {
        switch screen {
        case .Movies:
            switch getMoviesSection(with: indexPath) {
            case .NowPlaying:
                coordinator?.startItemListCoordinator(viewController: viewController, for: cell, at: indexPath, with: nowPlayingItems)
            case .Popular:
                coordinator?.startItemListCoordinator(viewController: viewController, for: cell, at: indexPath, with: popularItems)
            case .TopRated:
                coordinator?.startItemListCoordinator(viewController: viewController, for: cell, at: indexPath, with: topRatedItems)
            case .Upcoming:
                coordinator?.startItemListCoordinator(viewController: viewController, for: cell, at: indexPath, with: upcomingItems)
            }
        case .TVShows:
            switch getTVShowsSection(with: indexPath) {
            case .OnTheAir:
                coordinator?.startItemListCoordinator(viewController: viewController, for: cell, at: indexPath, with: nowPlayingItems)
            case .Popular:
                coordinator?.startItemListCoordinator(viewController: viewController, for: cell, at: indexPath, with: popularItems)
            case .TopRated:
                coordinator?.startItemListCoordinator(viewController: viewController, for: cell, at: indexPath, with: topRatedItems)
            }
        }
    }
    
    func didEndDisplaying(at indexPath: IndexPath) {
        coordinator?.stopItemListCoordinator(at: indexPath)
    }
    
    func showForwardedItemDetails() {
        guard let forwardedItemId = forwardedItemId else { return }
        
        switch screen {
        case .Movies:
            coordinator?.showDetailsOf(id: forwardedItemId, type: .Movie)
        case .TVShows:
            coordinator?.showDetailsOf(id: forwardedItemId, type: .TVShow)
        }
    }
    
    func fetchNextItems(at indexPath: IndexPath) {
        switch screen {
        case .Movies:
            switch getMoviesSection(with: indexPath) {
            case .NowPlaying:
                nowPlayingPage += 1
                interactor.perform(Discover.Request.FetchNowPlayingMovies(page: nowPlayingPage))
            case .Popular:
                popularPage += 1
                interactor.perform(Discover.Request.FetchPopularMovies(page: popularPage))
            case .TopRated:
                topRatedPage += 1
                interactor.perform(Discover.Request.FetchTopRatedMovies(page: topRatedPage))
            case .Upcoming:
                upcomingPage += 1
                interactor.perform(Discover.Request.FetchUpcomingMovies(page: upcomingPage))
            }
        case .TVShows:
            switch getTVShowsSection(with: indexPath) {
            case .OnTheAir:
                nowPlayingPage += 1
                interactor.perform(Discover.Request.FetchOnTheAirTVShows(page: nowPlayingPage))
            case .Popular:
                popularPage += 1
                interactor.perform(Discover.Request.FetchPopularTVShows(page: popularPage))
            case .TopRated:
                topRatedPage += 1
                interactor.perform(Discover.Request.FetchTopRatedTVShows(page: topRatedPage))
            }
        }
    }
    
    private func addSections() {
        switch screen {
        case .Movies:
            Discover.Sections.Movies.allCases.forEach {
                switch $0 {
                case .NowPlaying:
                    interactor.perform(Discover.Request.FetchNowPlayingMovies(page: nowPlayingPage))
                case .Popular:
                    interactor.perform(Discover.Request.FetchPopularMovies(page: popularPage))
                case .TopRated:
                    interactor.perform(Discover.Request.FetchTopRatedMovies(page: topRatedPage))
                case .Upcoming:
                    interactor.perform(Discover.Request.FetchUpcomingMovies(page: upcomingPage))
                }
                
                coordinator?.createItemList()
            }
        case .TVShows:
            Discover.Sections.TVShows.allCases.forEach {
                switch $0 {
                case .OnTheAir:
                    interactor.perform(Discover.Request.FetchOnTheAirTVShows(page: nowPlayingPage))
                case .Popular:
                    interactor.perform(Discover.Request.FetchPopularTVShows(page: popularPage))
                case .TopRated:
                    interactor.perform(Discover.Request.FetchTopRatedTVShows(page: topRatedPage))
                }
                
                coordinator?.createItemList()
            }
        }
    }
    
    private func convertIntoItems(movies: [Movie]) -> [Item] {
        return movies.filter {
            return !$0.pictureURL.isEmpty
        }.map {
            return Item(id: $0.id, pictureURL: $0.pictureURL, contentType: .Movie)
        }
    }
    
    private func convertIntoItems(tvShows: [TVShow]) -> [Item] {
        return tvShows.filter {
            return !$0.pictureURL.isEmpty
        }.map {
            return Item(id: $0.id, pictureURL: $0.pictureURL, contentType: .TVShow)
        }
    }
    
    private func getMoviesSection(with indexPath: IndexPath) -> Discover.Sections.Movies {
        if indexPath.row == 0 {
            return .NowPlaying
        } else if indexPath.row == 1 {
            return .Popular
        } else if indexPath.row == 2 {
            return .TopRated
        }
        
        return .Upcoming
    }
    
    private func getIndexPath(for section: Discover.Sections.Movies) -> IndexPath {
        switch section {
        case .NowPlaying:
            return IndexPath(row: 0, section: 0)
        case .Popular:
            return IndexPath(row: 1, section: 0)
        case .TopRated:
            return IndexPath(row: 2, section: 0)
        case .Upcoming:
            return IndexPath(row: 3, section: 0)
        }
    }
    
    private func getTVShowsSection(with indexPath: IndexPath) -> Discover.Sections.TVShows {
        if indexPath.row == 0 {
            return .OnTheAir
        } else if indexPath.row == 1 {
            return .Popular
        }
        
        return .TopRated
    }

    private func getIndexPath(for section: Discover.Sections.TVShows) -> IndexPath {
        switch section {
        case .OnTheAir:
            return IndexPath(row: 0, section: 0)
        case .Popular:
            return IndexPath(row: 1, section: 0)
        case .TopRated:
            return IndexPath(row: 2, section: 0)
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DiscoverPresenter: DiscoverInteractorOutput {
    
    // MARK: - Movies -
    func present(_ response: Discover.Response.MostPopularMoviesFetched) {
        guard let movie = response.movies.first else { return }
        forwardedItemId = movie.id
        
        output?.display(Discover.DisplayData.ForwardedItem(pictureURL: movie.originalPictureUrl))
    }
    
    func present(_ response: Discover.Response.NowPlayingMoviesFetched) {
        let items = convertIntoItems(movies: response.movies)
        nowPlayingPage == 1 ? nowPlayingItems = items : nowPlayingItems.append(contentsOf: items)
        
        coordinator?.updateItemListCoordinator(at: getIndexPath(for: Discover.Sections.Movies.NowPlaying), with: nowPlayingItems)
    }
    
    func present(_ response: Discover.Response.PopularMoviesFetched) {
        let items = convertIntoItems(movies: response.movies)
        popularPage == 1 ? popularItems = items : popularItems.append(contentsOf: items)
        
        coordinator?.updateItemListCoordinator(at: getIndexPath(for: Discover.Sections.Movies.Popular), with: popularItems)
    }
    
    func present(_ response: Discover.Response.TopRatedMoviesFetched) {
        let items = convertIntoItems(movies: response.movies)
        topRatedPage == 1 ? topRatedItems = items : topRatedItems.append(contentsOf: items)
        
        coordinator?.updateItemListCoordinator(at: getIndexPath(for: Discover.Sections.Movies.TopRated), with: topRatedItems)
    }
    
    func present(_ response: Discover.Response.UpcomingMoviesFetched) {
        let items = convertIntoItems(movies: response.movies)
        upcomingPage == 1 ? upcomingItems = items : upcomingItems.append(contentsOf: items)
        
        coordinator?.updateItemListCoordinator(at: getIndexPath(for: Discover.Sections.Movies.Upcoming), with: upcomingItems)
    }
    
    // MARK: - TVShows -
    func present(_ response: Discover.Response.MostPopularTVShowsFetched) {
        guard let tvShow = response.tvShows.first else { return }
        forwardedItemId = tvShow.id
        
        output?.display(Discover.DisplayData.ForwardedItem(pictureURL: tvShow.originalPictureUrl))
    }
    
    func present(_ response: Discover.Response.OnTheAirTVShowsFetched) {
        let items = convertIntoItems(tvShows: response.tvShows)
        nowPlayingPage == 1 ? nowPlayingItems = items : nowPlayingItems.append(contentsOf: items)
        
        coordinator?.updateItemListCoordinator(at: getIndexPath(for: Discover.Sections.TVShows.OnTheAir), with: nowPlayingItems)
    }
    
    func present(_ response: Discover.Response.PopularTVShowsFetched) {
        let items = convertIntoItems(tvShows: response.tvShows)
        popularPage == 1 ? popularItems = items : popularItems.append(contentsOf: items)
        
        coordinator?.updateItemListCoordinator(at: getIndexPath(for: Discover.Sections.TVShows.Popular), with: popularItems)
    }
    
    func present(_ response: Discover.Response.TopRatedTVShowsFetched) {
        let items = convertIntoItems(tvShows: response.tvShows)
        topRatedPage == 1 ? topRatedItems = items : topRatedItems.append(contentsOf: items)
        
        coordinator?.updateItemListCoordinator(at: getIndexPath(for: Discover.Sections.TVShows.TopRated), with: topRatedItems)
    }
    
    // MARK: - Error -
    func present(_ response: Discover.Response.Error) {
        output?.display(Discover.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
