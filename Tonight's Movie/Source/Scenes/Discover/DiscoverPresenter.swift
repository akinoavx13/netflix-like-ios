//
//  DiscoverPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class DiscoverPresenter {
    
    // MARK: - Properties -
    private let interactor: DiscoverInteractorInput
    private weak var coordinator: DiscoverCoordinatorInput?
    weak var output: DiscoverPresenterOutput?

    private var movies: [Movie]
    private var tvShows: [TVShow]
    
    // MARK: - Lifecycle -
    init(interactor: DiscoverInteractorInput, coordinator: DiscoverCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
        
        movies = []
        tvShows = []
    }
}

// MARK: - User Events -

extension DiscoverPresenter: DiscoverPresenterInput {
    
    // MARK: - Properties -
    var numberOfMovies: Int {
        return movies.count
    }
    
    var numberOfTVShows: Int {
        return tvShows.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        displayMoviesAndShows()
    }
    
    func viewWillDisappear() {
        interactor.cancel(Discover.Cancelable.FetchMovies())
        interactor.cancel(Discover.Cancelable.FetchTVShows())
    }
    
    func displayMoviesAndShows() {
        interactor.perform(Discover.Request.FetchMovies(page: 1))
        interactor.perform(Discover.Request.FetchTVShows(page: 1))
    }
    
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath) {
        if indexPath.section == 0 {
            let movie = movies[indexPath.row]
            
            item.display(title: movie.title, date: movie.date.format(from: "yyyy-MM-dd", to: "dd MMM yyyy"), pictureURL: movie.pictureURL)
        } else {
            let tvShow = tvShows[indexPath.row]
            
            item.display(title: tvShow.name, date: tvShow.date.format(from: "yyyy-MM-dd", to: "dd MMM yyyy"), pictureURL: tvShow.pictureURL)
        }
    }
    
    func configure(item: DiscoverHeaderViewProtocol, at indexPath: IndexPath) {
        item.display(title: indexPath.section == 0 ? Translation.Discover.movies : Translation.Discover.tvShows)
    }
    
    func configure(item: DiscoverFooterViewProtocol, at indexPath: IndexPath) {
        item.display(title: "\(Translation.Discover.showMore) ...")
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DiscoverPresenter: DiscoverInteractorOutput {
    func present(_ response: Discover.Response.MoviesFetched) {
        movies = Array(response.movies.prefix(4))
        output?.display(Discover.DisplayData.Movies(movies: movies))
    }
    
    func present(_ response: Discover.Response.TVShowsFetched) {
        tvShows = Array(response.tvShows.prefix(10))
        output?.display(Discover.DisplayData.TVShows(tvShows: tvShows))
    }
    
    func present(_ response: Discover.Response.Error) {
        output?.display(Discover.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
