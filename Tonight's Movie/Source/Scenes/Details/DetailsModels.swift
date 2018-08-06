//
//  DetailsModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

enum Details {
    enum Cancelable { }
    enum ContentType {
        case Movie, TVShow
    }
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Details.Cancelable {
    struct FetchMovies { }
    struct FetchTVShows { }
}

extension Details.Request {
    struct FetchMovie { let id: Int }
    struct FetchTVShow { let id: Int }
}

extension Details.Response {
    struct DetailsFetched {
        let title: String
        let backgroundURL: String
        let pictureURL: String
        let date: String
    }
    struct Error { let errorMessage: String }
}

extension Details.DisplayData {
    struct DetailsFetched {
        let title: String
        let backgroundURL: String
        let pictureURL: String
        let date: String
    }
    struct Error { let errorMessage: String }
}
