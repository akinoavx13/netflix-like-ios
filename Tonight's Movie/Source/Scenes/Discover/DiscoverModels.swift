//
//  DiscoverModels.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation

enum Discover {
    enum Screen {
        case Movies, TVShows
    }
    enum Sections { }
    enum Cancel { }
    enum Request { }
    enum Response { }
    enum DisplayData { }
}

extension Discover.Sections {
    enum Movies: CaseIterable {
        case NowPlaying, Upcoming, Popular, TopRated
    }
    enum TVShows: CaseIterable {
        case OnTheAir, Popular, TopRated
    }
}

extension Discover.Cancel {
    struct Requests { let screen: Discover.Screen }
}

extension Discover.Request {
    // MARK: - Movies -
    struct FetchMostPopularMovies { let page: Int }
    struct FetchNowPlayingMovies { let page: Int }
    struct FetchPopularMovies { let page: Int }
    struct FetchTopRatedMovies { let page: Int }
    struct FetchUpcomingMovies { let page: Int }
    
    // MARK: - TVShows -
    struct FetchMostPopularTVShows { let page: Int }
    struct FetchOnTheAirTVShows { let page: Int }
    struct FetchPopularTVShows { let page: Int }
    struct FetchTopRatedTVShows { let page: Int }
}

extension Discover.Response {
    // MARK: - Movies -
    struct MostPopularMoviesFetched { let movies: [Movie] }
    struct NowPlayingMoviesFetched { let movies: [Movie] }
    struct PopularMoviesFetched { let movies: [Movie] }
    struct TopRatedMoviesFetched { let movies: [Movie] }
    struct UpcomingMoviesFetched { let movies: [Movie] }
    
    // MARK: - TVShows -
    struct MostPopularTVShowsFetched { let tvShows: [TVShow] }
    struct OnTheAirTVShowsFetched { let tvShows: [TVShow] }
    struct PopularTVShowsFetched { let tvShows: [TVShow] }
    struct TopRatedTVShowsFetched { let tvShows: [TVShow] }
    
    // MARK: - Error -
    struct Error { let errorMessage: String }
}

extension Discover.DisplayData {
    struct ForwardedItem { let pictureURL: String }
    
    struct Error { let errorMessage: String }
}
