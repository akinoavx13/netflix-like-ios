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
        defaultParameters["language"] = "\(Locale.preferredLanguages.first ?? "en-US")"
    }
    
    // MARK: - Methods -
    func getPlayingMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        var parameters = defaultParameters
        parameters["region"] = Locale.current.languageCode?.uppercased()
        parameters["page"] = "\(page)"
        
        let request = Springbok
            .request("\(baseURL)/movie/now_playing",
                method: .get,
                parameters: parameters
            )
            .unwrap("results")
        
        request.responseCodable(completion: completion)
    }
    
    func getOnTheAirTVShows(page: Int, completion: @escaping (Result<[TVShow]>) -> Void) {
        var parameters = defaultParameters
        parameters["page"] = "\(page)"
        
        let request = Springbok
            .request("\(baseURL)/tv/on_the_air",
                method: .get,
                parameters: parameters
            )
            .unwrap("results")
        
        request.responseCodable(completion: completion)
    }
    
}
