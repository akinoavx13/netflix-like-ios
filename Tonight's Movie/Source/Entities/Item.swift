//
//  Item.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

struct Item: Codable {
    let id: Int
    let pictureURL: String
    let contentType: Item.ContentType
    
    var smallPictureUrl: String {
        return "https://image.tmdb.org/t/p/w500\(pictureURL)"
    }
    
    var originalPictureUrl: String {
        return "https://image.tmdb.org/t/p/original\(pictureURL)"
    }
    
    enum ContentType: String, Codable {
        case Movie, TVShow
    }
}
