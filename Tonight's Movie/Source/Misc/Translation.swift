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
    }
    
    struct Discover {
        static let title = NSLocalizedString("Discover", comment: "")
        static let movies = NSLocalizedString("Movies", comment: "")
        static let tvShows = NSLocalizedString("TV Shows", comment: "")
    }
        
}
