//
//  RequestsManager.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Alamofire

protocol HasRequestsManager {
    var requestsManager: RequestsManagerProtocol { get }
}

protocol RequestsManagerProtocol {
    func registerRequest(with screen: Screen, request: Request)
    func cancelRequests(of screen: Screen)
}

final class RequestsManager {
    
    // MARK: - Properties -
    private var requests: [Screen: [Request]]
    
    // MARK: - Lifecycle -
    init() {
        requests = [:]
        
        for screen in Screen.allCases {
            requests[screen] = []
        }
    }
}

extension RequestsManager: RequestsManagerProtocol {
    func registerRequest(with screen: Screen, request: Request) {
        requests[screen]?.append(request)        
    }
    
    func cancelRequests(of screen: Screen) {
        requests[screen]?.forEach {
            $0.cancel()
        }
        requests[screen]?.removeAll()
    }
}
