//
//  BookmarksModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
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
