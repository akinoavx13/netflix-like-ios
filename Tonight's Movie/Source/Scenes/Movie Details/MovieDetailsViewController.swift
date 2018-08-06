//
//  MovieDetailsViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: MovieDetailsPresenterInput!
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewCreated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Methods -
    class func instantiate(with presenter: MovieDetailsPresenterInput) -> MovieDetailsViewController {
        let name = "\(MovieDetailsViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! MovieDetailsViewController
        viewController.presenter = presenter
        
        return viewController
    }
    
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension MovieDetailsViewController: MovieDetailsPresenterOutput {

}
