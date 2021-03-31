//
//  Translation.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation

struct Translation {
    
    struct Default {
        static let error = NSLocalizedString("Error", comment: "")
        static let ok = NSLocalizedString("Ok", comment: "")
        static let movies = NSLocalizedString("Movies", comment: "")
        static let tvShows = NSLocalizedString("TVShows", comment: "")
    }
    
    struct Discover {
        static let showMore = NSLocalizedString("Show more", comment: "")
        static let currently = NSLocalizedString("Currently", comment: "")
        static let upcoming = NSLocalizedString("Upcoming", comment: "")
        static let popular = NSLocalizedString("Popular", comment: "")
        static let topRated = NSLocalizedString("Top rated", comment: "")
    }
    
    struct Details {
        static let mark = NSLocalizedString("Mark", comment: "")
        static let seasons = NSLocalizedString("Seasons", comment: "")
        static let addToList = NSLocalizedString("Add to my list", comment: "")
        static let removeFromList = NSLocalizedString("Remove from my list", comment: "")
        static let trailer = NSLocalizedString("Trailer", comment: "")
        static let recommendations = NSLocalizedString("Recommendations", comment: "")
    }
    
    struct Search {
        static let search = NSLocalizedString("Search", comment: "")
        static let noResult = NSLocalizedString("Your search returned no results", comment: "")
        static let searchMovieOrTVShow = NSLocalizedString("Search a movie or a tv show", comment: "")
    }
    
    struct Bookmarks {
        static let bookmarks = NSLocalizedString("Bookmarks", comment: "")
        static let noBookmark = NSLocalizedString("No movie or tv show saved", comment: "")
        static let recommendedMovies = NSLocalizedString("Recommended movies", comment: "")
        static let recommendedTVShows = NSLocalizedString("Recommended tv shows", comment: "")
    }
        
}
