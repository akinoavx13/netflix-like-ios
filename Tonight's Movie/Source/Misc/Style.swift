//
//  Style.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

struct Style {
    
    struct Cell {
        
        static var getItemSizeLarge: CGSize {
            var numberOfItemPerRow: CGFloat
            var offset: CGFloat
            
            switch UIDevice.current.userInterfaceIdiom {
            case .phone :
                numberOfItemPerRow = 3
                offset = 4
            case .pad:
                numberOfItemPerRow = 5
                offset = 2
            default:
                numberOfItemPerRow = 3
                offset = 4
            }
            
            let witdh = UIScreen.main.bounds.width / numberOfItemPerRow - (numberOfItemPerRow - 1) * offset
            
            return CGSize(width: witdh, height: witdh * 1.5)
        }
        
        static var getItemSizeDefault: CGSize {
            return CGSize(width: 106, height: 159)
        }
        
    }
    
}
