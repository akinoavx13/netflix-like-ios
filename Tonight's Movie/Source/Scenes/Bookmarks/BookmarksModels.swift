//
//  BookmarksModels.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation

enum Bookmarks {
    enum Cancel { }
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Bookmarks.Cancel {
    struct Requests { }
}

extension Bookmarks.Request {
    struct FetchSavedItems { }
    struct FetchRecommendationsMovies {
        let page: Int
        let id: Int
    }
    struct FetchRecommendationsTVShows {
        let page: Int
        let id: Int
    }
}

extension Bookmarks.Response {
    struct SavedItemsFetched { let items: [Item] }
    struct RecommendationsMoviesFetched { let movies: [Movie] }
    struct RecommendationsTVShowsFetched { let tvShows: [TVShow] }
    struct Error { let errorMessage: String }
}

extension Bookmarks.DisplayData {
    struct Items { }
    struct Error { let errorMessage: String }
}
