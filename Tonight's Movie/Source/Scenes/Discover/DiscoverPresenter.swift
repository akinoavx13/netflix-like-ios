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
        interactor.perform(Discover.Request.FetchMovies(page: 1))
        interactor.perform(Discover.Request.FetchTVShows(page: 1))
    }
    
    func viewWillDisappear() {
        interactor.cancel(Discover.Cancelable.FetchMovies())
        interactor.cancel(Discover.Cancelable.FetchTVShows())
    }
    
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath) {
        if indexPath.section == 0 {
            let movie = movies[indexPath.row]
            
            item.display(title: movie.title, date: movie.formattedDate(), pictureURL: movie.pictureURL)
        } else {
            let tvShow = tvShows[indexPath.row]
            
            item.display(title: tvShow.name, date: tvShow.formattedDate(), pictureURL: tvShow.pictureURL)
        }
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
        tvShows = response.tvShows
        output?.display(Discover.DisplayData.TVShows(tvShows: tvShows))
    }
    
    func present(_ response: Discover.Response.Error) {
        output?.display(Discover.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
