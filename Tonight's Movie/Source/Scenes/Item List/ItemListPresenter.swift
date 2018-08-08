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

    private var section: ItemList.Section
    
    private var nowPlayingMovies: [Movie]
    private var nowPlayingMoviesPage: Int

    private var upcomingMovies: [Movie]
    private var upcomingMoviesPage: Int
    
    private var popularMovies: [Movie]
    private var popularMoviesPage: Int
    
    private var topRatedMovies: [Movie]
    private var topRatedMoviesPage: Int
    
    // MARK: - Lifecycle -
    init(interactor: ItemListInteractorInput, coordinator: ItemListCoordinatorInput, section: ItemList.Section) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.section = section
        
        nowPlayingMovies = []
        nowPlayingMoviesPage = 1
        
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
            return nowPlayingMovies.count
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
            interactor.perform(ItemList.Request.FetchNowPlayingMovies(page: nowPlayingMoviesPage))
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
            let movie = nowPlayingMovies[indexPath.row]
            
            item.display(pictureURL: movie.smallPictureUrl)
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
            nowPlayingMoviesPage += 1
            interactor.perform(ItemList.Request.FetchNowPlayingMovies(page: nowPlayingMoviesPage))
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
        let movie: Movie?
        
        switch section {
        case .Currently:
            movie = nowPlayingMovies[indexPath.row]
        case .Upcoming:
            movie = upcomingMovies[indexPath.row]
        case .Popular:
            movie = popularMovies[indexPath.row]
        case .TopRated:
            movie = topRatedMovies[indexPath.row]
        }
        
        guard movie != nil else { return }
        
        coordinator?.showDetailsOf(movieId: movie!.id)
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension ItemListPresenter: ItemListInteractorOutput {
    func present(_ response: ItemList.Response.NowPlayingMoviesFetched) {
        nowPlayingMoviesPage == 1 ? nowPlayingMovies = response.movies : nowPlayingMovies.append(contentsOf: response.movies)
        
        output?.display(ItemList.DisplayData.Items())
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
    
    func present(_ response: ItemList.Response.Error) {
        output?.display(ItemList.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
