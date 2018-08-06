//
//  DiscoverFooterView.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

protocol DiscoverFooterViewProtocol {
    func display(title: String)
}

class DiscoverFooterView: UICollectionReusableView {
    
    // MARK: - Outlets -
    @IBOutlet weak var showMoreButton: UIButton! {
        didSet {
            showMoreButton.setTitle("", for: .normal)
            showMoreButton.setTitleColor(.white, for: .normal)
            showMoreButton.layer.cornerRadius = 4
            showMoreButton.layer.borderWidth = 1
            showMoreButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    // MARK: - Actions -
    @IBAction func showMoreButtonTapped(_ sender: UIButton) {
        
    }
}

extension DiscoverFooterView: DiscoverFooterViewProtocol {
    func display(title: String) {
        showMoreButton.setTitle(title, for: .normal)
    }
}
