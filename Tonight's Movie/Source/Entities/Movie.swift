//
//  Movie.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let pictureURL: String
    let backgroundURL: String
    let date: String
    let overview: String
    let runtime: Int
    let voteAverage: Double
    
    var smallPictureUrl: String {
        return "https://image.tmdb.org/t/p/w500\(pictureURL)"
    }
    
    var orignalBackgroundUrl: String {
        return "https://image.tmdb.org/t/p/original\(backgroundURL)"
    }
    
    var formattedDate: String {
        return date.format(from: "yyyy-mm-dd", to: "dd MMM yyyy")
    }
    
    var duration: String {
        return "\(runtime/60)h \(runtime % 60)min"
    }
    
    // MARK: - Lifecycle -
    init(dict: [String: Any]) {
        self.id = dict["id"] as? Int ?? 0
        self.title = dict["title"] as? String ?? ""
        self.pictureURL = dict["poster_path"] as? String ?? ""
        self.backgroundURL = dict["backdrop_path"] as? String ?? ""
        self.date = dict["release_date"] as? String ?? ""
        self.overview = dict["overview"] as? String ?? ""
        self.runtime = dict["runtime"] as? Int ?? 0
        self.voteAverage = dict["vote_average"] as? Double ?? 0
    }
}
