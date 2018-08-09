//
//  SearchHeaderView.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

protocol SearchHeaderViewProtocol {
    func display(title: String)
}

final class SearchHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = ""
            titleLabel.textColor = Colors.white
            titleLabel.font = Fonts.large
        }
    }
    
}

extension SearchHeaderView: SearchHeaderViewProtocol {
    func display(title: String) {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.text = title
            
            self.layoutIfNeeded()
        }
    }
}
