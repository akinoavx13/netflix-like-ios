//
//  DetailsModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

enum Details {
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Details.Request {
    struct FetchMovieDetails { let id: Int }
    struct FetchTVShowDetails { let id: Int }
}

extension Details.Response {
    struct MovieDetailsFetched { let movie: Movie }
    struct TVShowDetailsFetched { let tvShow: TVShow }
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
    struct Error { let errorMessage: String }
}
