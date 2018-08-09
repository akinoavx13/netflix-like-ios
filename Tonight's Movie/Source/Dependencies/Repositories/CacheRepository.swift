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
    
    // MARK: - Movies -
    func getHighestRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        return fallbackRepository.getHighestRatedMovies(page: page, completion: completion)
    }
    
    func getNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        return fallbackRepository.getNowPlayingMovies(page: page, completion: completion)
    }
    
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        return fallbackRepository.getUpcomingMovies(page: page, completion: completion)    }
    
    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        return fallbackRepository.getPopularMovies(page: page, completion: completion)
    }
    
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        return fallbackRepository.getTopRatedMovies(page: page, completion: completion)
    }
    
    func getMovieDetails(id: Int, completion: @escaping (Result<Movie>) -> Void) -> Request {
        return fallbackRepository.getMovieDetails(id: id, completion: completion)
    }
    
    func searchMovies(page: Int, query: String, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        return fallbackRepository.searchMovies(page: page, query: query, completion: completion)
    }
    
    func getRecommendationsMovies(page: Int, id: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        return fallbackRepository.getRecommendationsMovies(page: page, id: id, completion: completion)
    }
    
    // MARK: - TVShows -
    func getMostPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        return fallbackRepository.getMostPopularTVShows(page: page, completion: completion)
    }
    
    func getOnTheAirTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        return fallbackRepository.getOnTheAirTVShows(page: page, completion: completion)
    }
    
    func getPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        return fallbackRepository.getPopularTVShows(page: page, completion: completion)
    }
    
    func getTopRatedTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        return fallbackRepository.getTopRatedTVShows(page: page, completion: completion)
    }
    
    func getTVShowDetails(id: Int, completion: @escaping (Result<TVShow>) -> Void) -> Request {
        return fallbackRepository.getTVShowDetails(id: id, completion: completion)
    }
    
    func searchTVShows(page: Int, query: String, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        return fallbackRepository.searchTVShows(page: page, query: query, completion: completion)
    }
    
    func getRecommendationsTVShows(page: Int, id: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        return fallbackRepository.getRecommendationsTVShows(page: page, id: id, completion: completion)
    }
}

