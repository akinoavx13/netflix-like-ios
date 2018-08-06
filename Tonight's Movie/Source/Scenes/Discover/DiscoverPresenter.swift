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
    private var page: Int
    
    // MARK: - Lifecycle -
    init(interactor: DiscoverInteractorInput, coordinator: DiscoverCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
        
        movies = []
        page = 1
    }
}

// MARK: - User Events -

extension DiscoverPresenter: DiscoverPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int {
        return movies.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        interactor.perform(Discover.Request.FetchMovies(page: page))
    }
    
    func viewWillDisappear() {
        interactor.cancel(Discover.Cancelable.FetchMovies())
    }
    
    func configure(item: DiscoverCellProtocol, at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        item.display(title: movie.title, date: movie.formattedDate(), pictureURL: movie.pictureURL)
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DiscoverPresenter: DiscoverInteractorOutput {
    func present(_ response: Discover.Response.MoviesFetched) {
        movies = response.movies
        output?.display(Discover.DisplayData.Movies(movies: movies))
    }
    
    func present(_ response: Discover.Response.Error) {
        output?.display(Discover.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
