//
//  TVShow.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Foundation

struct TVShow: Codable {
    let id: Int
    let name: String
    let pictureURL: String
    let backgroundURL: String
    let date: String
    let overview: String

    enum CodingKeys: String, CodingKey {
        case pictureURL = "poster_path"
        case date = "first_air_date"
        case backgroundURL = "backdrop_path"
        
        case id, name, overview
    }

    var originalPictureUrl: String {
        return "https://image.tmdb.org/t/p/original\(pictureURL)"
    }
}
