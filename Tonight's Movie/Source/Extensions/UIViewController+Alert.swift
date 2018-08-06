//
//  UIViewController+Alert.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertError(message: String?) {
        let alert = UIAlertController(title: Translation.Default.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Translation.Default.ok, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
