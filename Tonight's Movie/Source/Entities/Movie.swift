//
//  Movie.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let pictureURL: String
    let backgroundURL: String
    let date: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case pictureURL = "poster_path"
        case date = "release_date"
        case backgroundURL = "backdrop_path"
        
        case id, title, overview
    }
}

