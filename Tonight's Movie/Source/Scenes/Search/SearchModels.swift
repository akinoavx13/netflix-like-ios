//
//  SearchModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
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
