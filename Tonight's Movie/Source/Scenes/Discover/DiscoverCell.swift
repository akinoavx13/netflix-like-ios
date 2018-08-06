//
//  DiscoverCell.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

protocol DiscoverCellProtocol {
    
}

final class DiscoverCell: UICollectionViewCell {

    // MARK: - Lifecycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        backgroundColor = .white
    }
}

extension DiscoverCell: DiscoverCellProtocol {
    
}
