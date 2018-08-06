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
    func getMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void)
    func getTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void)
    
    func getMovie(id: Int, completion: @escaping (Result<Movie>) -> Void)
    func getTVShow(id: Int, completion: @escaping (Result<TVShow>) -> Void)
        
}

