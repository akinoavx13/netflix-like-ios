//
//  UIView+Gradient.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

extension UIView {
    func gradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        layer.addSublayer(gradientLayer)
    }
}
