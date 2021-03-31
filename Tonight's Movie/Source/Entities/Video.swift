//
//  Video.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

struct Video {
    let key: String
    let site: String
    let type: String
    
    var iscomingFromYoutube: Bool {
        return site == "YouTube"
    }
    
    var isTrailer: Bool {
        return type == "Trailer"
    }
    
    // MARK: - Lifecycle -
    init(dict: [String: Any]) {
        self.key = dict["key"] as? String ?? ""
        self.site = dict["site"] as? String ?? ""
        self.type = dict["type"] as? String ?? ""
    }
}
