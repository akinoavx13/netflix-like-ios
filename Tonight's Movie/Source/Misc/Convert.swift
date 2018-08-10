//
//  Convert.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 10/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

struct Convert {
    static func convertIntoItems(movies: [Movie]) -> [Item] {
        return movies.filter {
            return !$0.pictureURL.isEmpty
        }.map {
            return Item(id: $0.id, pictureURL: $0.pictureURL, contentType: .Movie)
        }
    }
    
    static func convertIntoItems(tvShows: [TVShow]) -> [Item] {
        return tvShows.filter {
            return !$0.pictureURL.isEmpty
        }.map {
            return Item(id: $0.id, pictureURL: $0.pictureURL, contentType: .TVShow)
        }
    }
}
