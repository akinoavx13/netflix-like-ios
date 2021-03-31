//
//  Convert.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

struct Convert {
    static func convertIntoItems(movies: [Movie]) -> [Item] {
        return movies.filter {
            return !$0.pictureURL.isEmpty
        }.map {
            return Item(id: $0.id, pictureURL: $0.pictureURL, contentType: .Movie)
        }
    }
    
    static func convertIntoItems(tvShows: [TVShow]) -> [Item] {
        return tvShows.filter {
            return !$0.pictureURL.isEmpty
        }.map {
            return Item(id: $0.id, pictureURL: $0.pictureURL, contentType: .TVShow)
        }
    }
}
