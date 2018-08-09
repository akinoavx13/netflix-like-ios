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
    func getHighestRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void)
    func getNowPlayingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void)
    func getUpcomingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void)
    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void)
    func getTopRatedMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void)
    func getMovieDetails(id: Int, completion: @escaping (Result<Movie>) -> Void)
    func searchMovies(page: Int, query: String, completion: @escaping (Result<[Movie]>) -> Void)
    
    //MARK: - TVShows -
    func getMostPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void)
    func getOnTheAirTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void)
    func getPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void)
    func getTopRatedTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void)
    func getTVShowDetails(id: Int, completion: @escaping (Result<TVShow>) -> Void)
    func searchTVShows(page: Int, query: String, completion: @escaping (Result<[TVShow]>) -> Void)
}

