//
//  Style.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
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
    
}
