//
//  Repository.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Alamofire

protocol HasRepository {
    
    // MARK: - Properties -
    var repository: Repository { get }
}

protocol Repository {
    
    // MARK: - Movies -
    func getHighestRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request
    func getNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request
    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request
    func getMovieDetails(id: Int, completion: @escaping (Result<Movie>) -> Void) -> Request
    func searchMovies(page: Int, query: String, completion: @escaping (Result<[Movie]>) -> Void) -> Request
    func getRecommendationsMovies(page: Int, id: Int, completion: @escaping (Result<[Movie]>) -> Void) -> Request
    
    //MARK: - TVShows -
    func getMostPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getOnTheAirTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getTopRatedTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getTVShowDetails(id: Int, completion: @escaping (Result<TVShow>) -> Void) -> Request
    func searchTVShows(page: Int, query: String, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getRecommendationsTVShows(page: Int, id: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
}

