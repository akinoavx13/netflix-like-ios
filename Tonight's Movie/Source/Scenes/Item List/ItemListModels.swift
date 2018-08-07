//
//  ItemListModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

enum ItemList {
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension ItemList.Request {
    struct FetchNowPlayingMovies { let page: Int }
}

extension ItemList.Response {
    struct NowPlayingMoviesFetched { let movies: [Movie] }
    struct Error { let errorMessage: String }
}

extension ItemList.DisplayData {
    struct Items { }
    struct Error { let errorMessage: String }
}
