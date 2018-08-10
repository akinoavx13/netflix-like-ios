//
//  DetailsPresenter.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

class DetailsPresenter {
    
    // MARK: - Properties -
    let interactor: DetailsInteractorInput
    weak var coordinator: DetailsCoordinatorInput?
    weak var output: DetailsPresenterOutput?

    private let id: Int
    private let type: Item.ContentType
    private var item: Item?
    private var isItemSaved: Bool?
    private var recommendationItems: [Item]
    
    // MARK: - Lifecycle -
    init(interactor: DetailsInteractorInput, coordinator: DetailsCoordinatorInput, id: Int, type: Item.ContentType) {
        self.interactor = interactor
        self.coordinator = coordinator
        self.id = id
        self.type = type
        
        recommendationItems = []
    }
}

// MARK: - User Events -

extension DetailsPresenter: DetailsPresenterInput {
    func viewCreated() {
        switch type {
        case .Movie:
            interactor.perform(Details.Request.FetchMovieDetails(id: id))
            interactor.perform(Details.Request.FetchMovieVideos(id: id))
            interactor.perform(Details.Request.FetchMovieRecommendations(page: 1, id: id))
        case .TVShow:
            interactor.perform(Details.Request.FetchTVShowDetails(id: id))
            interactor.perform(Details.Request.FetchTVShowVideos(id: id))
        }
    }
    
    func viewWillDisappear() {
        interactor.cancel(Details.Cancel.Requests())
    }
    
    func closeButtonTapped() {
        coordinator?.dismiss()
    }
    
    func addButtonTapped() {
        guard
            let item = item,
            let isItemSaved = isItemSaved
        else { return }
        
        if isItemSaved {
            interactor.perform(Details.Request.RemoveItem(item: item))
        } else {
            interactor.perform(Details.Request.SaveItem(item: item))
        }
        
        interactor.perform(Details.Request.FetchIsItemSaved(item: item))
    }
    
    func showRecommendations(with viewController: UIViewController, into view: UIView) {
        coordinator?.showRecommendations(with: viewController, into: view, with: recommendationItems)
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension DetailsPresenter: DetailsInteractorOutput {
    // MARK: - Movies -
    func present(_ response: Details.Response.MovieDetailsFetched) {
        item = Item(id: id, pictureURL: response.movie.smallPictureUrl, contentType: .Movie)
        interactor.perform(Details.Request.FetchIsItemSaved(item: item!))
        
        output?.display(Details.DisplayData.Details(
            pictureURL: response.movie.smallPictureUrl,
            backgroundURL: response.movie.smallBackgroundUrl,
            mark: response.movie.voteAverage,
            date: response.movie.formattedDate,
            duration: response.movie.duration,
            overview: response.movie.overview
        ))
    }
    
    func present(_ response: Details.Response.MovieRecommendationsFetched) {
        recommendationItems = Convert.convertIntoItems(movies: response.movies)
        
        output?.display(Details.DisplayData.Recommendations())
    }
    
    // MARK: - TVShows -
    func present(_ response: Details.Response.TVShowDetailsFetched) {
        item = Item(id: id, pictureURL: response.tvShow.smallPictureUrl, contentType: .TVShow)
        interactor.perform(Details.Request.FetchIsItemSaved(item: item!))
        
        output?.display(Details.DisplayData.Details(
            pictureURL: response.tvShow.smallPictureUrl,
            backgroundURL: response.tvShow.smallbackgroundUrl,
            mark: response.tvShow.voteAverage,
            date: response.tvShow.formattedDate,
            duration: response.tvShow.duration,
            overview: response.tvShow.overview
        ))
    }
    
    // MARK: - Local -
    func present(_ response: Details.Response.IsItemSavedFetch) {
        isItemSaved = response.isSaved
        
        output?.display(Details.DisplayData.IsItemSaved(isSaved: response.isSaved))
    }
    
    // MARK: - Videos -
    func present(_ response: Details.Response.VideosFetched) {
        guard
            let video = response.videos.first,
            video.iscomingFromYoutube,
            video.isTrailer
        else { return }
        
        output?.display(Details.DisplayData.Trailer(url: "https://www.youtube.com/embed/\(video.key)"))
    }
    
    // MARK: - Error -
    func present(_ response: Details.Response.Error) {
        output?.display(Details.DisplayData.Error(errorMessage: response.errorMessage))
    }
}
