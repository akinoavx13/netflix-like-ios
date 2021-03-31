//
//  DiscoverInteractor.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation

class DiscoverInteractor {
    
    // MARK: - Properties -
    weak var output: DiscoverInteractorOutput?
    
    private let dependencies: FullDependencies
    
    // MARK: - Lifecycle -
    init(dependencies: FullDependencies = Dependencies.shared) {
        self.dependencies = dependencies
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension DiscoverInteractor: DiscoverInteractorInput {
    
    // MARK: - Movies -
    func perform(_ request: Discover.Request.FetchMostPopularMovies) {
        let request = dependencies
            .repository
            .getPopularMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Discover.Response.MostPopularMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }
    
    func perform(_ request: Discover.Request.FetchNowPlayingMovies) {
        let request = dependencies
            .repository
            .getNowPlayingMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Discover.Response.NowPlayingMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }
    
    func perform(_ request: Discover.Request.FetchPopularMovies) {
        let request = dependencies
            .repository
            .getPopularMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Discover.Response.PopularMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }
    
    func perform(_ request: Discover.Request.FetchTopRatedMovies) {
        let request = dependencies
            .repository
            .getTopRatedMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Discover.Response.TopRatedMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }
    
    func perform(_ request: Discover.Request.FetchUpcomingMovies) {
        let request = dependencies
            .repository
            .getUpcomingMovies(page: request.page) { (result) in
                switch result {
                case .success(let movies):
                    self.output?.present(Discover.Response.UpcomingMoviesFetched(movies: movies))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverMovies, request: request)
    }
    
    // MARK: - TVShows -
    func perform(_ request: Discover.Request.FetchMostPopularTVShows) {
        let request = dependencies
            .repository
            .getMostPopularTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(Discover.Response.MostPopularTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverTVShows, request: request)
    }
    
    func perform(_ request: Discover.Request.FetchOnTheAirTVShows) {
        let request = dependencies
            .repository
            .getOnTheAirTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(Discover.Response.OnTheAirTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverTVShows, request: request)
    }
    
    func perform(_ request: Discover.Request.FetchPopularTVShows) {
        let request = dependencies
            .repository
            .getPopularTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(Discover.Response.PopularTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverTVShows, request: request)
    }
    
    func perform(_ request: Discover.Request.FetchTopRatedTVShows) {
        let request = dependencies
            .repository
            .getTopRatedTVShows(page: request.page) { (result) in
                switch result {
                case .success(let tvShows):
                    self.output?.present(Discover.Response.TopRatedTVShowsFetched(tvShows: tvShows))
                case .failure(let error):
                    self.output?.present(Discover.Response.Error(errorMessage: error.localizedDescription))
                }
        }
        
        dependencies
            .requestsManager
            .registerRequest(with: .DiscoverTVShows, request: request)
    }
    
    // MARK: - Cancel -
    func cancel(_ request: Discover.Cancel.Requests) {        
        switch request.screen {
        case .Movies:
            dependencies
                .requestsManager
                .cancelRequests(of: .DiscoverMovies)
        case .TVShows:
            dependencies
                .requestsManager
                .cancelRequests(of: .DiscoverTVShows)
        }
    }
}
