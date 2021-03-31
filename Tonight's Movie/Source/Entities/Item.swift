//
//  Item.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

struct Item: Codable {
    let id: Int
    let pictureURL: String
    let contentType: Item.ContentType
    
    var smallPictureUrl: String {
        return "https://image.tmdb.org/t/p/w500\(pictureURL)"
    }
    
    var originalPictureUrl: String {
        return "https://image.tmdb.org/t/p/original\(pictureURL)"
    }
    
    enum ContentType: String, Codable {
        case Movie, TVShow
    }
}
