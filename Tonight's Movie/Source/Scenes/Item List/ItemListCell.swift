//
//  ItemListCell.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
            pictureImageView.alpha = 0
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
            pictureImageView.kf.setImage(with: url) { image, error, _, _ in
                if image != nil && error == nil {
                    UIView.animate(withDuration: Style.Animation.duration) {
                        self.pictureImageView.alpha = 1
                        
                        self.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    func didEndDisplaying() {
        pictureImageView.kf.cancelDownloadTask()
    }
}
