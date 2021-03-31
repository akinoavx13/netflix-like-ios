//
//  Dependencies.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
