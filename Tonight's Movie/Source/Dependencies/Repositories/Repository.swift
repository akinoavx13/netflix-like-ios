//
//  Repository.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
    
    // MARK: - TVShows -
    func getMostPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getOnTheAirTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getPopularTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getTopRatedTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getTVShowDetails(id: Int, completion: @escaping (Result<TVShow>) -> Void) -> Request
    func searchTVShows(page: Int, query: String, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    func getRecommendationsTVShows(page: Int, id: Int, completion: @escaping (Result<[TVShow]>) -> Void) -> Request
    
    // MARK: - Videos -
    func getMovieVideos(id: Int, completion: @escaping (Result<[Video]>) -> Void) -> Request
    func getTVShowVideos(id: Int, completion: @escaping (Result<[Video]>) -> Void) -> Request
}

