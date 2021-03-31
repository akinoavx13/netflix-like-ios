//
//  DiscoverCell.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
    
    @IBOutlet weak var contenairView: UIView!
    
    // MARK: - Lifecycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        selectionStyle = .none
        backgroundColor = Colors.black
    }    
}

extension DiscoverCell: DiscoverCellProtocol {
    func display(title: String) {
        UIView.animate(withDuration: Style.Animation.duration) {
            self.titleLabel.text = title
            
            self.layoutIfNeeded()
        }
    }
}
