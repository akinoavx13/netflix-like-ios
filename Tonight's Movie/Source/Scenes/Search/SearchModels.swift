//
//  SearchModels.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation

enum Search {
    enum Cancel { }
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Search.Cancel {
    struct Requests { }
}

extension Search.Request {
    struct SearchMovies {
        let page: Int
        let query: String
    }
    struct SearchTVShows {
        let page: Int
        let query: String
    }
}

extension Search.Response {
    struct MoviesFound { let movies: [Movie] }
    struct TVShowsFound { let tvShows: [TVShow] }
    struct Error { let errorMessage: String }
}

extension Search.DisplayData {
    struct Items { }
    struct Error { let errorMessage: String }
}
