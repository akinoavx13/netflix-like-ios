//
//  CacheRepository.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Springbok

final class CacheRepository {
    
    // MARK: - Properties -
    private let fallbackRepository: Repository
    
    // MARK: - Lifecycle -
    init(fallbackRepository: Repository) {
        self.fallbackRepository = fallbackRepository
    }
    
}

extension CacheRepository: Repository {
    
    // MARK: - Movies -
    func getMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        fallbackRepository.getMovies(page: page, completion: completion)
    }
    
    func getTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) {
        fallbackRepository.getTVShows(page: page, completion: completion)
    }
        
}

