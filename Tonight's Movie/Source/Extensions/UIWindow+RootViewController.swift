//
//  UIWindow+RootViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

extension UIWindow {
    func updateRootViewController(with viewController: UIViewController) {
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.rootViewController = viewController
        }, completion: nil)
    }
}
