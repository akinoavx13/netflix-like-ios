//
//  RequestsManager.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
