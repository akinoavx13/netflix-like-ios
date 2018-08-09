//
//  DetailsModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
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
    struct FetchMovieDetails { let id: Int }
    struct FetchTVShowDetails { let id: Int }
    struct SaveItem { let item: Item }
    struct FetchIsItemSaved { let item: Item }
    struct RemoveItem { let item: Item }
    struct FetchMovieVideos { let id: Int }
    struct FetchTVShowVideos { let id: Int }
}

extension Details.Response {
    struct MovieDetailsFetched { let movie: Movie }
    struct TVShowDetailsFetched { let tvShow: TVShow }
    struct IsItemSavedFetch { let isSaved: Bool }
    struct VideosFetched { let videos: [Video] }
    
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
    }
    struct IsItemSaved { let isSaved: Bool }
    struct Trailer { let url: String }
    struct Error { let errorMessage: String }
}
