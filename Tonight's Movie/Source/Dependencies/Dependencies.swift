//
//  Dependencies.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

typealias FullDependencies = HasRepository & HasRequestsManager & HasLocalManager

final class Dependencies {
    
    // MARK: - Properties -
    public static var shared = Dependencies()
    
    private(set) var repository: Repository
    private(set) var requestsManager: RequestsManagerProtocol
    private(set) var localManager: LocalManagerProtocol

    // MARK: - Lifecycle -
    private init() {
        requestsManager = RequestsManager()
        localManager = LocalManager()
        repository = CacheRepository(fallbackRepository: RemoteRepository())
    }
}

extension Dependencies: HasRepository & HasRequestsManager & HasLocalManager { }
