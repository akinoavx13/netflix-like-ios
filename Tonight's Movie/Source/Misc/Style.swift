//
//  Style.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import UIKit

struct Style {
    
    struct Animation {
        static var duration = 0.2
    }
    
    struct Cell {
        static var getItemSizeLarge: CGSize {
            let numberOfItemPerRow: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 3 : 5
            let witdh = UIScreen.main.bounds.width / numberOfItemPerRow - (numberOfItemPerRow - 1) * Style.CollectionView.offset
            
            return CGSize(width: witdh, height: witdh * 1.5)
        }
        
        static var getItemSizeDefault: CGSize {
            return CGSize(width: 106, height: 159)
        }
    }
    
    struct CollectionView {
        static var offset: CGFloat {
            return 4
        }
    }
    
    struct NavigationController {
        static func edit(_ navigationController: UINavigationController) {
            navigationController.navigationBar.tintColor = Colors.white
            navigationController.navigationBar.barTintColor = Colors.black
            navigationController.navigationBar.isTranslucent = true
            navigationController.navigationBar.titleTextAttributes = [
                .foregroundColor: Colors.white,
                .font: Fonts.large
            ]
        }
    }
}
