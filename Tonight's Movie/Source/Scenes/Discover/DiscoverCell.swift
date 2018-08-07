//
//  DiscoverCell.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

protocol DiscoverCellProtocol {
    func display(title: String)
}

final class DiscoverCell: UITableViewCell {
    
    // MARK: - Outlets -
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = ""
            titleLabel.textColor = Colors.white
            titleLabel.font = Fonts.large
        }
    }
    
    @IBOutlet weak var contenairView: UIView! {
        didSet {
            contenairView.backgroundColor = .blue
        }
    }
    
    // MARK: - Lifecycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        selectionStyle = .none
        backgroundColor = Colors.black
    }
    
}

extension DiscoverCell: DiscoverCellProtocol {
    func display(title: String) {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.text = title
            
            self.layoutIfNeeded()
        }
    }
}
