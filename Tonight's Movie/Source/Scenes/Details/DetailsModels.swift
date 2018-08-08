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
}

extension Details.Response {
    struct MovieDetailsFetched { let movie: Movie }
    struct Error { let errorMessage: String }
}

extension Details.DisplayData {
    struct MovieDetails { let movie: Movie }
    struct Error { let errorMessage: String }
}
