//
//  RemoteRepository.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Springbok

final class RemoteRepository: Repository {
    
    // MARK: - Properties -
    private let baseURL: String
    private var defaultParameters: [String: String]
    private let requestsManager: RequestsManagerProtocol
    
    // MARK: - Lifecycle -
    init(requestsManager: RequestsManagerProtocol) {
        self.requestsManager = requestsManager
        baseURL = "https://api.themoviedb.org/3"
        defaultParameters = [:]
        defaultParameters["api_key"] = "4cb1eeab94f45affe2536f2c684a5c9e"
    }
    
    // MARK: - Methods -
    
    func getAllMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        let request = Springbok
            .request("\(baseURL)/discover/movie",
                method: .get,
                parameters: [
                    "api_key": "4cb1eeab94f45affe2536f2c684a5c9e",
                    "sort_by": "popularity.desc",
                    "page": page
                ]
            )
            .unwrap("results")
        
        requestsManager.fetchMoviesRequest(with: request)
        request.responseCodable(completion: completion)
    }
    
}
