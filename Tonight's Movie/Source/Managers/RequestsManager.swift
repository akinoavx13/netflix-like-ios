//
//  RequestsManager.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Springbok

protocol HasRequestsManager {
    var requestsManager: RequestsManagerProtocol { get }
}

protocol RequestsManagerProtocol {
    func fetchMoviesRequest(with request: Request)
    func cancelFetchMoviesRequests()
    
    func fetchTVShowsRequest(with request: Request)
    func cancelFetchTVShowsRequests()
    
    func fetchMovieRequest(with request: Request)
    func cancelFetchMovieRequests()
    
    func fetchTVShowRequest(with request: Request)
    func cancelFetchTVShowRequests()
}

final class RequestsManager {
    
    // MARK: - Properties -
    private var movies: [String: Request]
    private var tvShows: [String: Request]
    private var movie: [String: Request]
    private var tvShow: [String: Request]
    
    // MARK: - Lifecycle -
    init() {
        movies = [:]
        tvShows = [:]
        movie = [:]
        tvShow = [:]
    }
    
    // MARK: - Methods -
    private func cancel(requests: [String: Request]) {
        for request in requests {
            Springbok.cancelRequest(request: request.value)
        }
    }
}

extension RequestsManager: RequestsManagerProtocol {
    
    func fetchMoviesRequest(with request: Request) {
        if let url = request.getUrl()?.absoluteString {
            movies[url] = request
        }
    }
    
    func cancelFetchMoviesRequests() {
        cancel(requests: movies)
        movies.removeAll()
    }
    
    func fetchTVShowsRequest(with request: Request) {
        if let url = request.getUrl()?.absoluteString {
            tvShows[url] = request
        }
    }
    
    func cancelFetchTVShowsRequests() {
        cancel(requests: tvShows)
        tvShows.removeAll()
    }
    
    func fetchMovieRequest(with request: Request) {
        if let url = request.getUrl()?.absoluteString {
            movie[url] = request
        }
    }
    
    func cancelFetchMovieRequests() {
        cancel(requests: movie)
        movie.removeAll()
    }
    
    func fetchTVShowRequest(with request: Request) {
        if let url = request.getUrl()?.absoluteString {
            tvShow[url] = request
        }
    }
    
    func cancelFetchTVShowRequests() {
        cancel(requests: tvShow)
        tvShow.removeAll()
    }
    
}

