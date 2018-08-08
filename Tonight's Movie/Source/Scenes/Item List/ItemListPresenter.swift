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

    private var upcomingMovies: [Movie]
    private var upcomingMoviesPage: Int
    
    private var popularMovies: [Movie]
    private var popularMoviesPage: Int
    
    private var topRatedMovies: [Movie]
    private var topRatedMoviesPage: Int
    
    // MARK: - Lifecycle -
    init(interactor: ItemListInteractorInput, coordinator: ItemListCoordinatorInput, section: ItemList.Section, screen: Discover.Screen) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.section = section
        self.screen = screen
        
        nowPlaying = []
        nowPlayingPage = 1
        
        upcomingMovies = []
        upcomingMoviesPage = 1
        
        popularMovies = []
        popularMoviesPage = 1
        
        topRatedMovies = []
        topRatedMoviesPage = 1
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
            return upcomingMovies.count
        case .Popular:
            return popularMovies.count
        case .TopRated:
            return topRatedMovies.count
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
            interactor.perform(ItemList.Request.FetchUpcomingMovies(page: upcomingMoviesPage))
        case .Popular:
            interactor.perform(ItemList.Request.FetchPopularMovies(page: popularMoviesPage))
        case .TopRated:
            interactor.perform(ItemList.Request.FetchTopRatedMovies(page: topRatedMoviesPage))
        }
    }
    
    func configure(item: ItemListCellProtocol, at indexPath: IndexPath) {
        switch section {
        case .Currently:
            let itemToShow = nowPlaying[indexPath.row]
            
            item.display(pictureURL: itemToShow.smallPictureUrl)
        case .Upcoming:
            let movie = upcomingMovies[indexPath.row]
            
            item.display(pictureURL: movie.smallPictureUrl)
        case .Popular:
            let movie = popularMovies[indexPath.row]

            item.display(pictureURL: movie.smallPictureUrl)
        case .TopRated:
            let movie = topRatedMovies[indexPath.row]

            item.display(pictureURL: movie.smallPictureUrl)
        }
    }
    
    func didEndDisplaying(item: ItemListCellProtocol, at indexPath: IndexPath) {
        item.didEndDisplaying()
    }
    
    func displayNext() {
        switch section {
        case .Currently:
            nowPlayingPage += 1
            interactor.perform(ItemList.Request.FetchNowPlayingMovies(page: nowPlayingPage))
        case .Upcoming:
            upcomingMoviesPage += 1
            interactor.perform(ItemList.Request.FetchUpcomingMovies(page: upcomingMoviesPage))
        case .Popular:
            popularMoviesPage += 1
            interactor.perform(ItemList.Request.FetchPopularMovies(page: popularMoviesPage))
        case .TopRated:
            topRatedMoviesPage += 1
            interactor.perform(ItemList.Request.FetchTopRatedMovies(page: topRatedMoviesPage))
        }
    }
    
    func showDetails(at indexPath: IndexPath) {
        let itemId: Int?
        
        switch section {
        case .Currently:
            itemId = nowPlaying[indexPath.row].id
        case .Upcoming:
            itemId = 0
//            movie = upcomingMovies[indexPath.row]
        case .Popular:
            itemId = 0
//            movie = popularMovies[indexPath.row]
        case .TopRated:
            itemId = 0
//            movie = topRatedMovies[indexPath.row]
        }
        
        coordinator?.showDetailsOf(movieId: itemId!)
    }
    
    private func convertMoviesIntoItems(movies: [Movie]) -> [Item] {
        return movies.compactMap { (movie) in
            return Item(id: movie.id, pictureURL: movie.pictureURL, contentType: .Movie)
        }
    }
    
    private func convertTVShowIntoItems(tvShows: [TVShow]) -> [Item] {
        return tvShows.compactMap { (tvShow) in
            return Item(id: tvShow.id, pictureURL: tvShow.pictureURL, contentType: .TVShow)
        }
    }
    
    private func displayDataCurrently(with items: [Item]) {
        nowPlayingPage == 1 ? nowPlaying = items : nowPlaying.append(contentsOf: items)
        
        output?.display(ItemList.DisplayData.Items())
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension ItemListPresenter: ItemListInteractorOutput {
    func present(_ response: ItemList.Response.NowPlayingMoviesFetched) {
        let items = convertMoviesIntoItems(movies: response.movies)
        
        displayDataCurrently(with: items)
    }
    
    func present(_ response: ItemList.Response.UpcomingMoviesFetched) {
        upcomingMoviesPage == 1 ? upcomingMovies = response.movies : upcomingMovies.append(contentsOf: response.movies)
        
        output?.display(ItemList.DisplayData.Items())
    }
    
    func present(_ response: ItemList.Response.PopularMoviesFetched) {
        popularMoviesPage == 1 ? popularMovies = response.movies : popularMovies.append(contentsOf: response.movies)
        
        output?.display(ItemList.DisplayData.Items())
    }
    
    func present(_ response: ItemList.Response.TopRatedMoviesFetched) {
        topRatedMoviesPage == 1 ? topRatedMovies = response.movies : topRatedMovies.append(contentsOf: response.movies)
        
        output?.display(ItemList.DisplayData.Items())
    }
    
    func present(_ response: ItemList.Response.OnTheAirTVShowsFetched) {
        let items = convertTVShowIntoItems(tvShows: response.tvShows)
        
        displayDataCurrently(with: items)
    }
    
    func present(_ response: ItemList.Response.Error) {
        output?.display(ItemList.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
