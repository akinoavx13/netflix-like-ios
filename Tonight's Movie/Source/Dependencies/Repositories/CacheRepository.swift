//
//  CacheRepository.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Alamofire

final class CacheRepository {
    
    // MARK: - Properties -
    private let fallbackRepository: Repository
    
    // MARK: - Lifecycle -
    init(fallbackRepository: Repository) {
        self.fallbackRepository = fallbackRepository
    }
    
}

extension CacheRepository: Repository {
    func getHighestRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        fallbackRepository.getHighestRatedMovies(page: page, completion: completion)
    }
    
    func getNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        fallbackRepository.getNowPlayingMovies(page: page, completion: completion)
    }
    
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        fallbackRepository.getUpcomingMovies(page: page, completion: completion)
    }
    
    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        fallbackRepository.getPopularMovies(page: page, completion: completion)
    }
    
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        fallbackRepository.getTopRatedMovies(page: page, completion: completion)
    }
}

