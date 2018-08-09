//
//  CacheRepository.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Alamofire
import Cache

final class CacheRepository {
    
    // MARK: - Properties -
    private let fallbackRepository: Repository
    
    private let moviesStorage: Storage<[Movie]>?
    private let movieStorage: Storage<Movie>?
    
    private let tvShowsStorage: Storage<[TVShow]>?
    private let tvShowStorage: Storage<TVShow>?
    
    // MARK: - Lifecycle -
    init(fallbackRepository: Repository) {
        self.fallbackRepository = fallbackRepository
        
        moviesStorage = try? Storage(
            diskConfig: DiskConfig(name: "movies"),
            memoryConfig: MemoryConfig(expiry: .seconds(10 * 60), countLimit: 25, totalCostLimit: 25),
            transformer: TransformerFactory.forCodable(ofType: [Movie].self)
        )
        
        movieStorage = try? Storage(
            diskConfig: DiskConfig(name: "movie"),
            memoryConfig: MemoryConfig(expiry: .seconds(10 * 60), countLimit: 10, totalCostLimit: 10),
            transformer: TransformerFactory.forCodable(ofType: Movie.self)
        )
        
        tvShowsStorage = try? Storage(
            diskConfig: DiskConfig(name: "tvshows"),
            memoryConfig: MemoryConfig(expiry: .seconds(10 * 60), countLimit: 25, totalCostLimit: 25),
            transformer: TransformerFactory.forCodable(ofType: [TVShow].self)
        )
        
        tvShowStorage = try? Storage(
            diskConfig: DiskConfig(name: "tvshow"),
            memoryConfig: MemoryConfig(expiry: .seconds(10 * 60), countLimit: 10, totalCostLimit: 10),
            transformer: TransformerFactory.forCodable(ofType: TVShow.self)
        )
    }
}

extension CacheRepository: Repository {
    
    // MARK: - Movies -
    func getHighestRatedMovies(page: Int, completion: @escaping (Alamofire.Result<[Movie]>) -> Void) {
        guard let storage = moviesStorage else {
            fallbackRepository.getHighestRatedMovies(page: page, completion: completion)
            
            return
        }
        
        do {
            let movies = try storage.object(forKey: "getHighestRatedMovies/\(page)")
            
            completion(Alamofire.Result.success(movies))
            fallbackRepository.getHighestRatedMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getHighestRatedMovies/\(page)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getHighestRatedMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getHighestRatedMovies/\(page)")
                }
                completion(result)
            }
        }
    }
    
    func getNowPlayingMovies(page: Int, completion: @escaping (Alamofire.Result<[Movie]>) -> Void) {
        guard let storage = moviesStorage else {
            fallbackRepository.getNowPlayingMovies(page: page, completion: completion)
            
            return
        }
        
        do {
            let movies = try storage.object(forKey: "getNowPlayingMovies/\(page)")
            
            completion(Alamofire.Result.success(movies))
            fallbackRepository.getNowPlayingMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getNowPlayingMovies/\(page)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getNowPlayingMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getNowPlayingMovies/\(page)")
                }
                completion(result)
            }
        }
    }
    
    func getUpcomingMovies(page: Int, completion: @escaping (Alamofire.Result<[Movie]>) -> Void) {
        guard let storage = moviesStorage else {
            fallbackRepository.getUpcomingMovies(page: page, completion: completion)
            
            return
        }
        
        do {
            let movies = try storage.object(forKey: "getUpcomingMovies/\(page)")
            
            completion(Alamofire.Result.success(movies))
            fallbackRepository.getUpcomingMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getUpcomingMovies/\(page)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getUpcomingMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getUpcomingMovies/\(page)")
                }
                completion(result)
            }
        }
    }
    
    func getPopularMovies(page: Int, completion: @escaping (Alamofire.Result<[Movie]>) -> Void) {
        guard let storage = moviesStorage else {
            fallbackRepository.getPopularMovies(page: page, completion: completion)
            
            return
        }
        
        do {
            let movies = try storage.object(forKey: "getPopularMovies/\(page)")
            
            completion(Alamofire.Result.success(movies))
            fallbackRepository.getPopularMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getPopularMovies/\(page)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getPopularMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getPopularMovies/\(page)")
                }
                completion(result)
            }
        }
    }
    
    func getTopRatedMovies(page: Int, completion: @escaping (Alamofire.Result<[Movie]>) -> Void) {
        guard let storage = moviesStorage else {
            fallbackRepository.getTopRatedMovies(page: page, completion: completion)
            
            return
        }
        
        do {
            let movies = try storage.object(forKey: "getTopRatedMovies/\(page)")
            
            completion(Alamofire.Result.success(movies))
            fallbackRepository.getTopRatedMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getTopRatedMovies/\(page)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getTopRatedMovies(page: page) { (result) in
                if case let .success(movies) = result {
                    try? storage.setObject(movies, forKey: "getTopRatedMovies/\(page)")
                }
                completion(result)
            }
        }
    }
    
    func getMovieDetails(id: Int, completion: @escaping (Alamofire.Result<Movie>) -> Void) {
        guard let storage = movieStorage else {
            fallbackRepository.getMovieDetails(id: id, completion: completion)
            
            return
        }
        
        do {
            let movie = try storage.object(forKey: "getMovieDetails/\(id)")
            
            completion(Alamofire.Result.success(movie))
            fallbackRepository.getMovieDetails(id: id) { (result) in
                if case let .success(movie) = result {
                    try? storage.setObject(movie, forKey: "getMovieDetails/\(id)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getMovieDetails(id: id) { (result) in
                if case let .success(movie) = result {
                    try? storage.setObject(movie, forKey: "getMovieDetails/\(id)")
                }
                completion(result)
            }
        }
    }
    
    func searchMovies(page: Int, query: String, completion: @escaping (Alamofire.Result<[Movie]>) -> Void) {
        fallbackRepository.searchMovies(page: page, query: query, completion: completion)
    }
    
    // MARK: - TVShows -
    func getMostPopularTVShows(page: Int, completion: @escaping (Alamofire.Result<[TVShow]>) -> Void) {
        guard let storage = tvShowsStorage else {
            fallbackRepository.getMostPopularTVShows(page: page, completion: completion)
            
            return
        }
        
        do {
            let tvShows = try storage.object(forKey: "getMostPopularTVShows/\(page)")
            
            completion(Alamofire.Result.success(tvShows))
            fallbackRepository.getMostPopularTVShows(page: page) { (result) in
                if case let .success(tvShows) = result {
                    try? storage.setObject(tvShows, forKey: "getMostPopularTVShows/\(page)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getMostPopularTVShows(page: page) { (result) in
                if case let .success(tvShows) = result {
                    try? storage.setObject(tvShows, forKey: "getMostPopularTVShows/\(page)")
                }
                completion(result)
            }
        }
    }
    
    func getOnTheAirTVShows(page: Int, completion: @escaping (Alamofire.Result<[TVShow]>) -> Void) {
        guard let storage = tvShowsStorage else {
            fallbackRepository.getOnTheAirTVShows(page: page, completion: completion)
            
            return
        }
        
        do {
            let tvShows = try storage.object(forKey: "getOnTheAirTVShows/\(page)")
            
            completion(Alamofire.Result.success(tvShows))
            fallbackRepository.getOnTheAirTVShows(page: page) { (result) in
                if case let .success(tvShows) = result {
                    try? storage.setObject(tvShows, forKey: "getOnTheAirTVShows/\(page)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getOnTheAirTVShows(page: page) { (result) in
                if case let .success(tvShows) = result {
                    try? storage.setObject(tvShows, forKey: "getOnTheAirTVShows/\(page)")
                }
                completion(result)
            }
        }
    }
    
    func getPopularTVShows(page: Int, completion: @escaping (Alamofire.Result<[TVShow]>) -> Void) {
        guard let storage = tvShowsStorage else {
            fallbackRepository.getPopularTVShows(page: page, completion: completion)
            
            return
        }
        
        do {
            let tvShows = try storage.object(forKey: "getPopularTVShows/\(page)")
            
            completion(Alamofire.Result.success(tvShows))
            fallbackRepository.getPopularTVShows(page: page) { (result) in
                if case let .success(tvShows) = result {
                    try? storage.setObject(tvShows, forKey: "getPopularTVShows/\(page)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getPopularTVShows(page: page) { (result) in
                if case let .success(tvShows) = result {
                    try? storage.setObject(tvShows, forKey: "getPopularTVShows/\(page)")
                }
                completion(result)
            }
        }
    }
    
    func getTopRatedTVShows(page: Int, completion: @escaping (Alamofire.Result<[TVShow]>) -> Void) {
        guard let storage = tvShowsStorage else {
            fallbackRepository.getTopRatedTVShows(page: page, completion: completion)
            
            return
        }
        
        do {
            let tvShows = try storage.object(forKey: "getTopRatedTVShows/\(page)")
            
            completion(Alamofire.Result.success(tvShows))
            fallbackRepository.getTopRatedTVShows(page: page) { (result) in
                if case let .success(tvShows) = result {
                    try? storage.setObject(tvShows, forKey: "getTopRatedTVShows/\(page)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getTopRatedTVShows(page: page) { (result) in
                if case let .success(tvShows) = result {
                    try? storage.setObject(tvShows, forKey: "getTopRatedTVShows/\(page)")
                }
                completion(result)
            }
        }
    }
    
    func getTVShowDetails(id: Int, completion: @escaping (Alamofire.Result<TVShow>) -> Void) {
        guard let storage = tvShowStorage else {
            fallbackRepository.getTVShowDetails(id: id, completion: completion)
            
            return
        }
        
        do {
            let tvShow = try storage.object(forKey: "getTVShowDetails/\(id)")
            
            completion(Alamofire.Result.success(tvShow))
            fallbackRepository.getTVShowDetails(id: id) { (result) in
                if case let .success(tvShow) = result {
                    try? storage.setObject(tvShow, forKey: "getTVShowDetails/\(id)")
                }
                completion(result)
            }
        } catch {
            fallbackRepository.getTVShowDetails(id: id) { (result) in
                if case let .success(tvShow) = result {
                    try? storage.setObject(tvShow, forKey: "getTVShowDetails/\(id)")
                }
                completion(result)
            }
        }
    }
}

