//
//  Repository.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Springbok

protocol HasRepository {
    
    // MARK: - Properties -
    var repository: Repository { get }
}

protocol Repository {
    
    // MARK: - Movies -
    func getPlayingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void)
    func getOnTheAirTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void)
    
}

