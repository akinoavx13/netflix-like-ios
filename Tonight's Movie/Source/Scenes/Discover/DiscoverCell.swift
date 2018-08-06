//
//  DiscoverCell.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

protocol DiscoverCellProtocol {
    func display(title: String, date: String, pictureURL: String)
}

final class DiscoverCell: UICollectionViewCell {

    // MARK: - Outlets -
    @IBOutlet weak var pictureImageView: UIImageView! {
        didSet {
            pictureImageView.contentMode = .scaleAspectFill
            pictureImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = ""
            titleLabel.numberOfLines = 2
            titleLabel.textColor = .white
            titleLabel.font = Fonts.bodyMedium
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = ""
            dateLabel.textColor = .white
            dateLabel.font = Fonts.small
        }
    }
    
    // MARK: - Lifecycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        backgroundColor = Colors.blueNightsDarker
        layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        pictureImageView.cancelDownloadTask()
    }
}

extension DiscoverCell: DiscoverCellProtocol {
    func display(title: String, date: String, pictureURL: String) {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.text = title
            self.dateLabel.text = date
            self.layoutIfNeeded()
        }

        pictureImageView.setImage(url: "https://image.tmdb.org/t/p/w500\(pictureURL)")
    }
}
