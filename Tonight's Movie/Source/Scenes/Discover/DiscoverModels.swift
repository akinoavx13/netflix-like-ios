//
//  DiscoverModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

enum Discover {
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Discover.Request {
    struct FetchHighestRatedMovies { let page: Int }
}

extension Discover.Response {
    struct HighestRatedMoviesFetched { let movies: [Movie] }
    struct Error { let errorMessage: String }
}

extension Discover.DisplayData {
    struct HighestRatedMovie { let movie: Movie }
    struct Error { let errorMessage: String }
}
