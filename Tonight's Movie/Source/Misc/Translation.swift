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
        static let discover = NSLocalizedString("Discover", comment: "")
        static let showMore = NSLocalizedString("Show more", comment: "")
        static let currently = NSLocalizedString("Currently", comment: "")
        static let upcoming = NSLocalizedString("Upcoming", comment: "")
        static let lastly = NSLocalizedString("Lastly", comment: "")
        static let popular = NSLocalizedString("Popular", comment: "")
        static let topRated = NSLocalizedString("Top rated", comment: "")
    }
        
}
