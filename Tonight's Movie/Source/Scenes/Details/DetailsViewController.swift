//
//  DetailsViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: DetailsPresenterInput!

    // MARK: - Outlets -
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewCreated()
    }
    
    // MARK: - Methods -
    class func instantiate(with presenter: DetailsPresenterInput) -> DetailsViewController {
        let name = "\(DetailsViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! DetailsViewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Actions -
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension DetailsViewController: DetailsPresenterOutput {

}
