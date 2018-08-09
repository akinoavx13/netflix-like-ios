//
//  Translation.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
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
    }
    
    struct Search {
        static let search = NSLocalizedString("Search", comment: "")
        static let noResult = NSLocalizedString("Your search returned no results", comment: "")
        static let searchMovieOrTVShow = NSLocalizedString("Search a movie or a tv show", comment: "")
    }
    
    struct Bookmarks {
        static let bookmarks = NSLocalizedString("Bookmarks", comment: "")
    }
        
}
