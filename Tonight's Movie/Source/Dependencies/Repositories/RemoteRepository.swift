//
//  RemoteRepository.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Alamofire

final class RemoteRepository: Repository {
    
    // MARK: - Properties -
    private let baseURL: String
    private var defaultParameters: Parameters
    private let requestsManager: RequestsManagerProtocol
    
    // MARK: - Lifecycle -
    init(requestsManager: RequestsManagerProtocol) {
        self.requestsManager = requestsManager
        baseURL = "https://api.themoviedb.org/3"
        defaultParameters = [:]
        defaultParameters["api_key"] = "4cb1eeab94f45affe2536f2c684a5c9e"
        defaultParameters["language"] = "\(Locale.preferredLanguages.first ?? "en-US")"
    }
    
    // MARK: - Movies -
    func getHighestRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["certification_country"] = Locale.current.languageCode?.uppercased()
        parameters["certification"] = "R"
        parameters["sort_by"] = "vote_average.desc"
        
        Alamofire
            .request("\(baseURL)/discover/movie", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["region"] = Locale.current.languageCode?.uppercased()

        Alamofire
            .request("\(baseURL)/movie/now_playing", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["region"] = Locale.current.languageCode?.uppercased()
        
        Alamofire
            .request("\(baseURL)/movie/upcoming", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        Alamofire
            .request("\(baseURL)/movie/popular", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        Alamofire
            .request("\(baseURL)/movie/top_rated", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getMovieDetails(id: Int, completion: @escaping (Result<Movie>) -> Void) {
        Alamofire
            .request("\(baseURL)/movie/\(id)", parameters: defaultParameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
                    return completion(.failure(response.error!))
                }
                
                guard
                    let results = response.result.value as? [String: Any]
                    else {
                        return completion(.failure(AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)))
                }

                return completion(.success(Movie(dict: results)))
        }
    }
    
    func searchMovies(page: Int, query: String, completion: @escaping (Result<[Movie]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["query"] = "\(query)"
        
        Alamofire
            .request("\(baseURL)/search/movie", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getRecommendationsMovies(page: Int, id: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        Alamofire
            .request("\(baseURL)/movie/\(id)/recommendations", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }

    // MARK: - TVShows -
    func getMostPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["certification_country"] = Locale.current.languageCode?.uppercased()
        parameters["certification"] = "R"
        parameters["sort_by"] = "popularity.desc"
        
        Alamofire
            .request("\(baseURL)/discover/tv", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getOnTheAirTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        Alamofire
            .request("\(baseURL)/tv/on_the_air", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        Alamofire
            .request("\(baseURL)/tv/popular", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getTopRatedTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        Alamofire
            .request("\(baseURL)/tv/top_rated", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getTVShowDetails(id: Int, completion: @escaping (Result<TVShow>) -> Void) {
        Alamofire
            .request("\(baseURL)/tv/\(id)", parameters: defaultParameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
                    return completion(.failure(response.error!))
                }
                
                guard
                    let results = response.result.value as? [String: Any]
                    else {
                        return completion(.failure(AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)))
                }
                
                return completion(.success(TVShow(dict: results)))
        }
    }
    
    func searchTVShows(page: Int, query: String, completion: @escaping (Result<[TVShow]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        parameters["query"] = "\(query)"
        
        Alamofire
            .request("\(baseURL)/search/tv", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
    
    func getRecommendationsTVShows(page: Int, id: Int, completion: @escaping (Result<[TVShow]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        Alamofire
            .request("\(baseURL)/tv/\(id)/recommendations", parameters: parameters)
            .validate()
            .responseJSON { (response) in
                if response.error != nil {
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
    }
}
