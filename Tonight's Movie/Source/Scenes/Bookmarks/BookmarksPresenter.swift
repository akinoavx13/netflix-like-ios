//
//  BookmarksPresenter.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation

class BookmarksPresenter {
    
    // MARK: - Properties -
    let interactor: BookmarksInteractorInput
    weak var coordinator: BookmarksCoordinatorInput?
    weak var output: BookmarksPresenterOutput?

    private var savedItems: [Item]
    
    private var recommendedMovies: [Movie]
    private var recommendedTVShows: [TVShow]
    
    // MARK: - Lifecycle -
    init(interactor: BookmarksInteractorInput, coordinator: BookmarksCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
        
        savedItems = []
        recommendedMovies = []
        recommendedTVShows = []
    }
}

// MARK: - User Events -

extension BookmarksPresenter: BookmarksPresenterInput {
    
    // MARK: - Properties -
    var numberOfSavedItems: Int {
        return savedItems.count
    }
    
    var numberOfRecommendedMovies: Int {
        return recommendedMovies.count
    }
    
    var numberOfRecommendedTVShows: Int {
        return recommendedTVShows.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        
    }
    
    func viewWillAppear() {
        recommendedMovies.removeAll()
        recommendedTVShows.removeAll()
        interactor.perform(Bookmarks.Request.FetchSavedItems())
    }
    
    func viewWillDisappear() {
        interactor.cancel(Bookmarks.Cancel.Requests())
    }
    
    func configure(item: ItemListCellProtocol, at indexPath: IndexPath) {
        if indexPath.section == 0 {
            let savedItem = savedItems[indexPath.row]
            item.display(pictureURL: savedItem.pictureURL)
        } else if indexPath.section == 1 {
            let recommendedMovie = recommendedMovies[indexPath.row]
            item.display(pictureURL: recommendedMovie.smallPictureUrl)
        } else if indexPath.section == 2 {
            let recommendedTVShow = recommendedTVShows[indexPath.row]
            item.display(pictureURL: recommendedTVShow.smallPictureUrl)
        }
    }
    
    func configure(item: SearchHeaderViewProtocol, at indexPath: IndexPath) {
        if indexPath.section == 0 {
            item.display(title: Translation.Bookmarks.bookmarks)
        } else if indexPath.section == 1 {
            item.display(title: Translation.Bookmarks.recommendedMovies)
        } else if indexPath.section == 2 {
            item.display(title: Translation.Bookmarks.recommendedTVShows)
        }
    }
    
    func didEndDisplaying(item: ItemListCellProtocol, at indexPath: IndexPath) {
        item.didEndDisplaying()
    }
    
    func showDetails(at indexPath: IndexPath) {
        if indexPath.section == 0 {
            let item = savedItems[indexPath.row]
            coordinator?.showDetailsOf(id: item.id, type: item.contentType)
        } else if indexPath.section == 1 {
            let item = recommendedMovies[indexPath.row]
            coordinator?.showDetailsOf(id: item.id, type: .Movie)
        } else if indexPath.section == 2 {
            let item = recommendedTVShows[indexPath.row]
            coordinator?.showDetailsOf(id: item.id, type: .TVShow)
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension BookmarksPresenter: BookmarksInteractorOutput {
    func present(_ response: Bookmarks.Response.SavedItemsFetched) {
        savedItems = response.items
        
        savedItems.forEach {
            switch $0.contentType {
            case .Movie:
                interactor.perform(Bookmarks.Request.FetchRecommendationsMovies(page: 1, id: $0.id))
            case .TVShow:
                interactor.perform(Bookmarks.Request.FetchRecommendationsTVShows(page: 1, id: $0.id))
            }
        }
        
        output?.display(Bookmarks.DisplayData.Items())
    }
    
    func present(_ response: Bookmarks.Response.RecommendationsMoviesFetched) {
        let movies = response.movies.filter { (recommendedMovie) -> Bool in
            return !savedItems.contains(where: { (item) -> Bool in
                return item.contentType == .Movie && recommendedMovie.id == item.id
            }) && !recommendedMovies.contains(where: { (movie) -> Bool in
                return recommendedMovie.id == movie.id
            })
        }.prefix(5)
        
        recommendedMovies.append(contentsOf: Array(movies))
        output?.display(Bookmarks.DisplayData.Items())
    }
    
    func present(_ response: Bookmarks.Response.RecommendationsTVShowsFetched) {
        let tvShows = response.tvShows.filter { (recommendedTVShow) -> Bool in
            return !savedItems.contains(where: { (item) -> Bool in
                return item.contentType == .TVShow && recommendedTVShow.id == item.id
            }) && !recommendedTVShows.contains(where: { (tvShow) -> Bool in
                return recommendedTVShow.id == tvShow.id
            })
        }.prefix(5)
        
        recommendedTVShows.append(contentsOf: tvShows)
        output?.display(Bookmarks.DisplayData.Items())
    }
    
    func present(_ response: Bookmarks.Response.Error) {
        output?.display(Bookmarks.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
