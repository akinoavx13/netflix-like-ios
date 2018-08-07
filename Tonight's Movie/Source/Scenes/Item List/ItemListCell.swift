//
//  ItemListCell.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

protocol ItemListCellProtocol {
    func display(pictureURL: String)
    func didEndDisplaying()
}

final class ItemListCell: UICollectionViewCell {
    
    // MARK: - Properties -
    @IBOutlet weak var pictureImageView: UIImageView! {
        didSet {
            pictureImageView.contentMode = .scaleAspectFill
            pictureImageView.clipsToBounds = true
        }
    }
    
    // MARK: - Lifecycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = .clear
    }
}

extension ItemListCell: ItemListCellProtocol {
    func display(pictureURL: String) {
        if let url = URL(string: pictureURL) {
            pictureImageView.kf.setImage(with: url)
        }
    }
    
    func didEndDisplaying() {
        pictureImageView.kf.cancelDownloadTask()
    }
}
