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
}

extension Bookmarks.Response {
    struct SavedItemsFetched { let items: [Item] }
}

extension Bookmarks.DisplayData {
    struct Items { }
}
