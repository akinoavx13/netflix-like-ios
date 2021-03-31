//
//  Coordinator.swift
//  Tonight's Movie
//
//Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import UIKit

protocol Coordinator: class {
    
    // MARK: - Properties -
    var children: [Coordinator] { get set }
    
    // MARK: - Methods -
    func start()
}
