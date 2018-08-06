//
//  DiscoverModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

enum Discover {
    enum Cancelable { }
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Discover.Cancelable {
    struct FetchMovies { }
}

extension Discover.Request {
    struct FetchMovies { let page: Int }
}

extension Discover.Response {
    struct MoviesFetched { let movies: [Movie] }
    struct Error { let errorMessage: String }
}

extension Discover.DisplayData {
    struct Movies { let movies: [Movie] }
    struct Error { let errorMessage: String }
}
