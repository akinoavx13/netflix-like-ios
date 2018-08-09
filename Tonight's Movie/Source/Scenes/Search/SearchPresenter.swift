//
//  SearchPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

class SearchPresenter {
    
    // MARK: - Properties -
    let interactor: SearchInteractorInput
    weak var coordinator: SearchCoordinatorInput?
    weak var output: SearchPresenterOutput?
    
    private var movies: [Movie]
    
    // MARK: - Lifecycle -
    init(interactor: SearchInteractorInput, coordinator: SearchCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
        
        movies = []
    }
}

// MARK: - User Events -

extension SearchPresenter: SearchPresenterInput {
    
    // MARK: - Properties -
    var numberOfMovies: Int {
        return movies.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        
    }
    
    func search(with query: String) {
        interactor.perform(Search.Request.SearchMovies(page: 1, query: query))
    }
    
    func configure(item: ItemListCellProtocol, at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        item.display(pictureURL: movie.smallPictureUrl)
    }
    
    func didEndDisplaying(item: ItemListCellProtocol, at indexPath: IndexPath) {
        item.didEndDisplaying()
    }
    
    func displayEmptyState() {
        movies.removeAll()
        output?.display(Search.DisplayData.Movies(movies: movies))
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension SearchPresenter: SearchInteractorOutput {

    func present(_ response: Search.Response.MoviesFound) {
        movies = response.movies
        output?.display(Search.DisplayData.Movies(movies: movies))
    }
    
    func present(_ response: Search.Response.Error) {
        output?.display(Search.DisplayData.Error(errorMessage: response.errorMessage))
    }
    
}
