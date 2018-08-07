//
//  DiscoverViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: DiscoverPresenterInput!

    // MARK: - Outlets -
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.electromagnetic
        
        presenter.viewCreated()
    }
    
    // MARK: - Methods -
    class func instantiate(with presenter: DiscoverPresenterInput) -> DiscoverViewController {
        let name = "\(DiscoverViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! DiscoverViewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Actions -
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension DiscoverViewController: DiscoverPresenterOutput {

}
