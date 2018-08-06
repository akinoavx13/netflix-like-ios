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
}

final class RequestsManager {
    
    // MARK: - Properties -
    private var movies: [String: Request]
    private var movieDetails: [String: Request]
    
    // MARK: - Lifecycle -
    init() {
        movies = [:]
        movieDetails = [:]
    }
    
    // MARK: - Methods -
    private func cancel(requests: [String: Request]) {
        for request in requests {
            Springbok.cancelRequest(request: request.value)
        }
    }
}

extension RequestsManager: RequestsManagerProtocol {
    
    // MARK: - All movies -
    func fetchMoviesRequest(with request: Request) {
        if let url = request.getUrl()?.absoluteString {
            movies[url] = request
        }
    }
    
    func cancelFetchMoviesRequests() {
        cancel(requests: movies)
        movies.removeAll()
    }
    
}

