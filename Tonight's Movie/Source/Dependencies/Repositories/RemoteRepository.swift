//
//  RemoteRepository.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import Alamofire

final class RemoteRepository {
    
    // MARK: - Properties -
    private let baseURL: String
    private var defaultParameters: Parameters
    private let manager: SessionManager
    
    // MARK: - Lifecycle -
    init() {
        baseURL = "https://api.themoviedb.org/3"
        defaultParameters = [:]
        defaultParameters["api_key"] = "4cb1eeab94f45affe2536f2c684a5c9e"
        defaultParameters["language"] = "\(Locale.preferredLanguages.first ?? "en-US")"
        
        manager = Alamofire.SessionManager.default
    }
    
    // MARK: - Methods -
    private func send(request: DataRequest, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        request
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
                    if (response.error! as NSError).code == NSURLErrorCancelled { return }
                    return completion(.failure(response.error!))
                }
                
                guard
                    let json = response.result.value as? [String: Any],
                    let results = json["results"] as? [[String: Any]]
                    else {
                        return completion(.failure(AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)))
                }
                
                let movies = results.compactMap { dict in
                    return Movie(dict: dict)
                }
                
                return completion(.success(movies))
        }
        
        return request
    }
    
    private func send(request: DataRequest, completion: @escaping (Result<Movie>) -> Void) -> Request {
        request
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
                    if (response.error! as NSError).code == NSURLErrorCancelled { return }
                    return completion(.failure(response.error!))
                }
                
                guard
                    let results = response.result.value as? [String: Any]
                    else {
                        return completion(.failure(AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)))
                }
                
                return completion(.success(Movie(dict: results)))
        }
        
        return request
    }
    
    private func send(request: DataRequest, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        request
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
                    if (response.error! as NSError).code == NSURLErrorCancelled { return }
                    return completion(.failure(response.error!))
                }
                
                guard
                    let json = response.result.value as? [String: Any],
                    let results = json["results"] as? [[String: Any]]
                    else {
                        return completion(.failure(AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)))
                }
                
                let tvShows = results.compactMap { dict in
                    return TVShow(dict: dict)
                }
                
                return completion(.success(tvShows))
        }
        
        return request
    }
    
    private func send(request: DataRequest, completion: @escaping (Result<TVShow>) -> Void) -> Request {
        request
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
                    if (response.error! as NSError).code == NSURLErrorCancelled { return }
                    return completion(.failure(response.error!))
                }
                
                guard
                    let results = response.result.value as? [String: Any]
                    else {
                        return completion(.failure(AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)))
                }
                
                return completion(.success(TVShow(dict: results)))
            }
    
        return request
    }
    
    private func send(request: DataRequest, completion: @escaping (Result<[Video]>) -> Void) -> Request {
        request
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
                    if (response.error! as NSError).code == NSURLErrorCancelled { return }
                    return completion(.failure(response.error!))
                }
                
                guard
                    let json = response.result.value as? [String: Any],
                    let results = json["results"] as? [[String: Any]]
                    else {
                        return completion(.failure(AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)))
                }
                
                let videos = results.compactMap { dict in
                    return Video(dict: dict)
                }
                
                return completion(.success(videos))
        }
        
        return request
    }
}

extension RemoteRepository: Repository {
    // MARK: - Movies -
    func getHighestRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["certification_country"] = Locale.current.languageCode?.uppercased()
        parameters["certification"] = "R"
        parameters["sort_by"] = "vote_average.desc"
        
        return send(request: manager.request("\(baseURL)/discover/movie", parameters: parameters),
                    completion: completion)
    }
    
    func getNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["region"] = Locale.current.languageCode?.uppercased()

        return send(request: manager.request("\(baseURL)/movie/now_playing", parameters: parameters),
                    completion: completion)
    }
    
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["region"] = Locale.current.languageCode?.uppercased()

        return send(request: manager.request("\(baseURL)/movie/upcoming", parameters: parameters),
                    completion: completion)
    }
    
    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        return send(request: manager.request("\(baseURL)/movie/popular", parameters: parameters),
                    completion: completion)
    }
    
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        return send(request: manager.request("\(baseURL)/movie/top_rated", parameters: parameters),
                    completion: completion)
    }
    
    func getMovieDetails(id: Int, completion: @escaping (Result<Movie>) -> Void) -> Request {
        return send(request: manager.request("\(baseURL)/movie/\(id)", parameters: defaultParameters),
                    completion: completion)
    }
    
    func searchMovies(page: Int, query: String, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["query"] = "\(query)"
        
        return send(request: manager.request("\(baseURL)/search/movie", parameters: parameters),
                    completion: completion)
    }
    
    func getRecommendationsMovies(page: Int, id: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        return send(request: manager.request("\(baseURL)/movie/\(id)/recommendations", parameters: parameters),
                    completion: completion)
    }

    // MARK: - TVShows -
    func getMostPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["certification_country"] = Locale.current.languageCode?.uppercased()
        parameters["certification"] = "R"
        parameters["sort_by"] = "popularity.desc"
        
        return send(request: manager.request("\(baseURL)/discover/tv", parameters: parameters),
                    completion: completion)
    }
    
    func getOnTheAirTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        return send(request: manager.request("\(baseURL)/tv/on_the_air", parameters: parameters),
                    completion: completion)
    }
    
    func getPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        return send(request: manager.request("\(baseURL)/tv/popular", parameters: parameters),
                    completion: completion)
    }
    
    func getTopRatedTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        return send(request: manager.request("\(baseURL)/tv/top_rated", parameters: parameters),
                    completion: completion)
    }
    
    func getTVShowDetails(id: Int, completion: @escaping (Result<TVShow>) -> Void) -> Request {
        return send(request: manager.request("\(baseURL)/tv/\(id)", parameters: defaultParameters),
                    completion: completion)
    }
    
    func searchTVShows(page: Int, query: String, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["query"] = "\(query)"
        
        return send(request: manager.request("\(baseURL)/search/tv", parameters: parameters),
                    completion: completion)
    }
    
    func getRecommendationsTVShows(page: Int, id: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"

        return send(request: manager.request("\(baseURL)/tv/\(id)/recommendations", parameters: parameters),
                    completion: completion)
    }
    
    // MARK: - Videos -
    func getMovieVideos(id: Int, completion: @escaping (Result<[Video]>) -> Void) -> Request {
        return send(request: manager.request("\(baseURL)/movie/\(id)/videos", parameters: defaultParameters),
                    completion: completion)
    }
    
    func getTVShowVideos(id: Int, completion: @escaping (Result<[Video]>) -> Void) -> Request {
        return send(request: manager.request("\(baseURL)/tv/\(id)/videos", parameters: defaultParameters),
                    completion: completion)
    }
}
