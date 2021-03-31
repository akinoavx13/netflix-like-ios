//
//  TVShow.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation

struct TVShow: Codable {
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
        return "\(numberOfSeasons) \(Translation.Details.seasons), \(numberOfEpisodes) Ep."
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
