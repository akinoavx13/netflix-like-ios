//
//  ItemListPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class ItemListPresenter {
    
    // MARK: - Properties -
    let interactor: ItemListInteractorInput
    weak var coordinator: ItemListCoordinatorInput?
    weak var output: ItemListPresenterOutput?

    private let section: ItemList.Section
    private let screen: Discover.Screen
    
    private var nowPlaying: [Item]
    private var nowPlayingPage: Int

    private var upcoming: [Item]
    private var upcomingPage: Int
    
    private var popular: [Item]
    private var popularPage: Int
    
    private var topRated: [Item]
    private var topRatedPage: Int
    
    // MARK: - Lifecycle -
    init(interactor: ItemListInteractorInput, coordinator: ItemListCoordinatorInput, section: ItemList.Section, screen: Discover.Screen) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.section = section
        self.screen = screen
        
        nowPlaying = []
        nowPlayingPage = 1
        
        upcoming = []
        upcomingPage = 1
        
        popular = []
        popularPage = 1
        
        topRated = []
        topRatedPage = 1
    }
}

// MARK: - User Events -

extension ItemListPresenter: ItemListPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int {
        switch section {
        case .Currently:
            return nowPlaying.count
        case .Upcoming:
            return upcoming.count
        case .Popular:
            return popular.count
        case .TopRated:
            return topRated.count
        }
    }
    
    // MARK: - Methods -
    func viewCreated() {
        switch section {
        case .Currently:
            switch screen {
            case .Movies:
                interactor.perform(ItemList.Request.FetchNowPlayingMovies(page: nowPlayingPage))
            case .TVShows:
                interactor.perform(ItemList.Request.FetchOnTheAirTVShows(page: nowPlayingPage))
            }
        case .Upcoming:
            switch screen {
            case .Movies:
                interactor.perform(ItemList.Request.FetchUpcomingMovies(page: upcomingPage))
            case .TVShows:
                break
            }
        case .Popular:
            switch screen {
            case .Movies:
                interactor.perform(ItemList.Request.FetchPopularMovies(page: popularPage))
            case .TVShows:
                interactor.perform(ItemList.Request.FetchPopularTVShows(page: popularPage))
            }
        case .TopRated:
            switch screen {
            case .Movies:
                interactor.perform(ItemList.Request.FetchTopRatedMovies(page: topRatedPage))
            case .TVShows:
                interactor.perform(ItemList.Request.FetchTopRatedTVShows(page: topRatedPage))
            }
        }
    }
    
    func configure(item: ItemListCellProtocol, at indexPath: IndexPath) {
        switch section {
        case .Currently:
            let itemToShow = nowPlaying[indexPath.row]
            
            item.display(pictureURL: itemToShow.smallPictureUrl)
        case .Upcoming:
            let itemToShow = upcoming[indexPath.row]
            
            item.display(pictureURL: itemToShow.smallPictureUrl)
        case .Popular:
            let itemToShow = popular[indexPath.row]

            item.display(pictureURL: itemToShow.smallPictureUrl)
        case .TopRated:
            let itemToShow = topRated[indexPath.row]

            item.display(pictureURL: itemToShow.smallPictureUrl)
        }
    }
    
    func didEndDisplaying(item: ItemListCellProtocol, at indexPath: IndexPath) {
        item.didEndDisplaying()
    }
    
    func displayNext() {
        switch section {
        case .Currently:
            nowPlayingPage += 1
            switch screen {
            case .Movies:
                interactor.perform(ItemList.Request.FetchNowPlayingMovies(page: nowPlayingPage))
            case .TVShows:
                interactor.perform(ItemList.Request.FetchOnTheAirTVShows(page: nowPlayingPage))
            }
        case .Upcoming:
            upcomingPage += 1
            switch screen {
            case .Movies:
                interactor.perform(ItemList.Request.FetchUpcomingMovies(page: upcomingPage))
            case .TVShows:
                break
            }
        case .Popular:
            popularPage += 1
            switch screen {
            case .Movies:
                interactor.perform(ItemList.Request.FetchPopularMovies(page: popularPage))
            case .TVShows:
                interactor.perform(ItemList.Request.FetchPopularTVShows(page: popularPage))
            }
        case .TopRated:
            topRatedPage += 1
            switch screen {
            case .Movies:
                interactor.perform(ItemList.Request.FetchTopRatedMovies(page: topRatedPage))
            case .TVShows:
                interactor.perform(ItemList.Request.FetchTopRatedTVShows(page: topRatedPage))
            }
        }
    }
    
    func showDetails(at indexPath: IndexPath) {
        let id: Int?
        
        switch section {
        case .Currently:
            id = nowPlaying[indexPath.row].id
        case .Upcoming:
            id = upcoming[indexPath.row].id
        case .Popular:
            id = popular[indexPath.row].id
        case .TopRated:
            id = topRated[indexPath.row].id
        }
        
        switch screen {
        case .Movies:
            coordinator?.showDetailsOf(id: id!, type: .Movie)
        case .TVShows:
            coordinator?.showDetailsOf(id: id!, type: .TVShow)
        }
    }
    
    private func convertMoviesIntoItems(movies: [Movie]) -> [Item] {
        return movies.filter {
            return $0.pictureURL != ""
        }
        .compactMap { (movie) in
            return Item(id: movie.id, pictureURL: movie.pictureURL, contentType: .Movie)
        }
    }
    
    private func convertTVShowIntoItems(tvShows: [TVShow]) -> [Item] {
        return tvShows.filter {
            return $0.pictureURL != ""
        }
        .compactMap { (tvShow) in
            return Item(id: tvShow.id, pictureURL: tvShow.pictureURL, contentType: .TVShow)
        }
    }
    
    private func displayCurrentlyItems(with items: [Item]) {
        nowPlayingPage == 1 ? nowPlaying = items : nowPlaying.append(contentsOf: items)
        
        output?.display(ItemList.DisplayData.Items())
    }
    
    private func displayPopularItems(with items: [Item]) {
        popularPage == 1 ? popular = items : popular.append(contentsOf: items)
        
        output?.display(ItemList.DisplayData.Items())
    }
    
    private func displayTopRatedItems(with items: [Item]) {
        topRatedPage == 1 ? topRated = items : topRated.append(contentsOf: items)
        
        output?.display(ItemList.DisplayData.Items())
    }
    
    private func displayUpcomingItems(with items: [Item]) {
        upcomingPage == 1 ? upcoming = items : upcoming.append(contentsOf: items)
        
        output?.display(ItemList.DisplayData.Items())
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension ItemListPresenter: ItemListInteractorOutput {
    
    // MARK: - Movies -
    func present(_ response: ItemList.Response.NowPlayingMoviesFetched) {
        let items = convertMoviesIntoItems(movies: response.movies)
        
        displayCurrentlyItems(with: items)
    }
    
    func present(_ response: ItemList.Response.UpcomingMoviesFetched) {
        let items = convertMoviesIntoItems(movies: response.movies)
        
        displayUpcomingItems(with: items)
    }
    
    func present(_ response: ItemList.Response.PopularMoviesFetched) {
        let items = convertMoviesIntoItems(movies: response.movies)
        
        displayPopularItems(with: items)
    }
    
    func present(_ response: ItemList.Response.TopRatedMoviesFetched) {
        let items = convertMoviesIntoItems(movies: response.movies)
        
        displayTopRatedItems(with: items)
    }

    // MARK: - TVShows -
    func present(_ response: ItemList.Response.OnTheAirTVShowsFetched) {
        let items = convertTVShowIntoItems(tvShows: response.tvShows)
        
        displayCurrentlyItems(with: items)
    }
    
    func present(_ response: ItemList.Response.PopularTVShowsFetched) {
        let items = convertTVShowIntoItems(tvShows: response.tvShows)
        
        displayPopularItems(with: items)
    }
    
    func present(_ response: ItemList.Response.TopRatedTVShowsFetched) {
        let items = convertTVShowIntoItems(tvShows: response.tvShows)
        
        displayTopRatedItems(with: items)
    }
    
    // MARK: - Error -
    func present(_ response: ItemList.Response.Error) {
        output?.display(ItemList.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
