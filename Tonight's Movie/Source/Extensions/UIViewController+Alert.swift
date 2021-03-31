//
//  UIViewController+Alert.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import UIKit

extension UIViewController {
    
    func showAlertError(message: String?) {
        let alert = UIAlertController(title: Translation.Default.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Translation.Default.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
