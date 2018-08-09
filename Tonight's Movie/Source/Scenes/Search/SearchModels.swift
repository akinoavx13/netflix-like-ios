//
//  SearchModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

enum Search {
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Search.Request {
    struct SearchMovies {
        let page: Int
        let query: String
    }
}

extension Search.Response {
    struct MoviesFound { let movies: [Movie] }
    struct Error { let errorMessage: String }
}

extension Search.DisplayData {
    struct Movies { let movies: [Movie] }
    struct Error { let errorMessage: String }
}
