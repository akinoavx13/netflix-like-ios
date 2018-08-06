//
//  DiscoverHeaderView.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class DiscoverHeaderView: UICollectionReusableView {
    
    // MARK: - Outlets -
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = ""
            titleLabel.textColor = .white
            titleLabel.font = Fonts.header
        }
    }
    
}
