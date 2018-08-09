//
//  DiscoverModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

enum Discover {
    enum Screen {
        case Movies, TVShows
    }
    enum Cancel { }
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Discover.Cancel {
    struct Requests { let screen: Discover.Screen }
}

extension Discover.Request {
    struct FetchMostPopularMovies { let page: Int }
    struct FetchMostPopularTVShows { let page: Int }
}

extension Discover.Response {
    struct MostPopularMoviesFetched { let movies: [Movie] }
    struct MostPopularTVShowsFetched { let tvShows: [TVShow] }
    struct Error { let errorMessage: String }
}

extension Discover.DisplayData {
    struct ForwardedItem { let pictureURL: String }
    struct Error { let errorMessage: String }
}
