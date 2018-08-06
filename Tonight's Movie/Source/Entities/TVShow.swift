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
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case pictureURL = "poster_path"
        case date = "first_air_date"
        
        case id, name
    }
    
    // MARK: - Methods -
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: self.date) else {
            return ""
        }
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
}


