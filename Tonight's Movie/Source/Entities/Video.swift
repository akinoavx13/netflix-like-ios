//
//  Video.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

struct Video {
    let key: String
    let site: String
    let type: String
    
    var iscomingFromYoutube: Bool {
        return site == "YouTube"
    }
    
    var isTrailer: Bool {
        return type == "Trailer"
    }
    
    // MARK: - Lifecycle -
    init(dict: [String: Any]) {
        self.key = dict["key"] as? String ?? ""
        self.site = dict["site"] as? String ?? ""
        self.type = dict["type"] as? String ?? ""
    }
}
