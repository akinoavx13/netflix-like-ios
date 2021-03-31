//
//  DetailsModels.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation

enum Details {
    enum Cancel { }
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Details.Cancel {
    struct Requests { }
}

extension Details.Request {
    // MARK: - Movies -
    struct FetchMovieDetails { let id: Int }
    struct FetchMovieRecommendations {
        let page: Int
        let id: Int
    }
    
    // MARK: - TVShows -
    struct FetchTVShowDetails { let id: Int }
    struct FetchTVShowsRecommendations {
        let page: Int
        let id: Int
    }
    
    // MARK: - Videos -
    struct FetchMovieVideos { let id: Int }
    struct FetchTVShowVideos { let id: Int }
    
    // MARK: - Local -
    struct SaveItem { let item: Item }
    struct FetchIsItemSaved { let item: Item }
    struct RemoveItem { let item: Item }
}

extension Details.Response {
    // MARK: - Movies -
    struct MovieDetailsFetched { let movie: Movie }
    struct MovieRecommendationsFetched { let movies: [Movie] }
    
    // MARK: - TVShows -
    struct TVShowDetailsFetched { let tvShow: TVShow }
    struct TVShowRecommendationsFetched { let tvShows: [TVShow] }
    
    // MARK: - Videos -
    struct VideosFetched { let videos: [Video] }
    
    // MARK: - Local -
    struct IsItemSavedFetch { let isSaved: Bool }
    
    // MARK: - Error -
    struct Error { let errorMessage: String }
}

extension Details.DisplayData {
    struct Details {
        let pictureURL: String
        let backgroundURL: String
        let mark: Double
        let date: String
        let duration: String
        let overview: String
        let title: String
    }
    struct Recommendations { }
    struct IsItemSaved { let isSaved: Bool }
    struct Trailer { let url: String }
    struct Error { let errorMessage: String }
}
