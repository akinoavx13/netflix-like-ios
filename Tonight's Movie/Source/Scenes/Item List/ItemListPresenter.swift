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

    private var nowPlayingMovies: [Movie]
    private var nowPlayingMoviesPage: Int
    
    // MARK: - Lifecycle -
    init(interactor: ItemListInteractorInput, coordinator: ItemListCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
        
        nowPlayingMovies = []
        nowPlayingMoviesPage = 1
    }
}

// MARK: - User Events -

extension ItemListPresenter: ItemListPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int {
        return nowPlayingMovies.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        interactor.perform(ItemList.Request.FetchNowPlayingMovies(page: nowPlayingMoviesPage))
    }
    
    func configure(item: ItemListCellProtocol, at indexPath: IndexPath) {
        let movie = nowPlayingMovies[indexPath.row]
        
        item.display(pictureURL: movie.smallPictureUrl)
    }
    
    func displayNext() {
        nowPlayingMoviesPage += 1
        interactor.perform(ItemList.Request.FetchNowPlayingMovies(page: nowPlayingMoviesPage))
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension ItemListPresenter: ItemListInteractorOutput {
    func present(_ response: ItemList.Response.NowPlayingMoviesFetched) {
        nowPlayingMoviesPage == 1 ? nowPlayingMovies = response.movies : nowPlayingMovies.append(contentsOf: response.movies)
        
        output?.display(ItemList.DisplayData.Items())
    }
    
    func present(_ response: ItemList.Response.Error) {
        output?.display(ItemList.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
