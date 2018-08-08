//
//  TVShow.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Foundation

struct TVShow {
    let id: Int
    let name: String
    let pictureURL: String
    let backgroundURL: String
    let date: String
    let overview: String
    let voteAverage: Double
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    
    var smallPictureUrl: String {
        return "https://image.tmdb.org/t/p/w500\(pictureURL)"
    }
    
    var originalPictureUrl: String {
        return "https://image.tmdb.org/t/p/original\(pictureURL)"
    }

    var smallbackgroundUrl: String {
        return "https://image.tmdb.org/t/p/w500\(backgroundURL)"
    }
    
    var originalbackgroundUrl: String {
        return "https://image.tmdb.org/t/p/original\(backgroundURL)"
    }
    
    var formattedDate: String {
        return date.format(from: "yyyy-mm-dd", to: "dd MMM yyyy")
    }
    
    var duration: String {
        return "\(numberOfSeasons) \(Translation.Details.seasons), \(numberOfEpisodes) \(Translation.Details.episodes)"
    }
    
    // MARK: - Lifecycle -
    init(dict: [String: Any]) {
        self.id = dict["id"] as? Int ?? 0
        self.name = dict["name"] as? String ?? ""
        self.pictureURL = dict["poster_path"] as? String ?? ""
        self.backgroundURL = dict["backdrop_path"] as? String ?? ""
        self.date = dict["first_air_date"] as? String ?? ""
        self.overview = dict["overview"] as? String ?? ""
        self.voteAverage = dict["vote_average"] as? Double ?? 0
        self.numberOfEpisodes = dict["number_of_episodes"] as? Int ?? 0
        self.numberOfSeasons = dict["number_of_seasons"] as? Int ?? 0
    }
}
