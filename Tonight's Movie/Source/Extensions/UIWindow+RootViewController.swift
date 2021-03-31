//
//  UIWindow+RootViewController.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import UIKit

extension UIWindow {
    func updateRootViewController(with viewController: UIViewController) {
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.rootViewController = viewController
        }, completion: nil)
    }
}
