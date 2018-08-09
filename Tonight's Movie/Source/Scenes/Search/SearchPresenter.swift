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
    private var tvShows: [TVShow]
    
    // MARK: - Lifecycle -
    init(interactor: SearchInteractorInput, coordinator: SearchCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
        
        movies = []
        tvShows = []
    }
}

// MARK: - User Events -

extension SearchPresenter: SearchPresenterInput {
    
    // MARK: - Properties -
    var numberOfMovies: Int {
        return movies.count
    }
    
    var numberOfTVShows: Int {
        return tvShows.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        
    }
    
    func viewWillDisappear() {
        interactor.cancel(Search.Cancel.Requests())
    }
    
    func search(with query: String) {
        interactor.cancel(Search.Cancel.Requests())
        interactor.perform(Search.Request.SearchMovies(page: 1, query: query))
        interactor.perform(Search.Request.SearchTVShows(page: 1, query: query))
    }
    
    func configure(item: ItemListCellProtocol, at indexPath: IndexPath) {
        if indexPath.section == 0 {
            let movie = movies[indexPath.row]
            
            item.display(pictureURL: movie.smallPictureUrl)
        } else if indexPath.section == 1 {
            let tvShow = tvShows[indexPath.row]
            
            item.display(pictureURL: tvShow.smallPictureUrl)
        }
    }
    
    func configure(item: SearchHeaderViewProtocol, at indexPath: IndexPath) {
        indexPath.section == 0 ? item.display(title: Translation.Default.movies) : item.display(title: Translation.Default.tvShows)
    }
    
    func didEndDisplaying(item: ItemListCellProtocol, at indexPath: IndexPath) {
        item.didEndDisplaying()
    }
    
    func displayEmptyState() {
        movies.removeAll()
        tvShows.removeAll()
        output?.display(Search.DisplayData.Items())
    }
    
    func showDetails(at indexPath: IndexPath) {
        if indexPath.section == 0 {
            let movie = movies[indexPath.row]
            coordinator?.showDetailsOf(id: movie.id, type: .Movie)
        } else if indexPath.section == 1 {
            let tvShow = tvShows[indexPath.row]
            coordinator?.showDetailsOf(id: tvShow.id, type: .TVShow)
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension SearchPresenter: SearchInteractorOutput {
    func present(_ response: Search.Response.MoviesFound) {
        movies = response.movies.filter({ (movie) -> Bool in
            return !movie.pictureURL.isEmpty
        })
        output?.display(Search.DisplayData.Items())
    }
    
    func present(_ response: Search.Response.TVShowsFound) {
        tvShows = response.tvShows.filter({ (tvShow) -> Bool in
            return !tvShow.pictureURL.isEmpty
        })
        output?.display(Search.DisplayData.Items())
    }
    
    func present(_ response: Search.Response.Error) {
        output?.display(Search.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
