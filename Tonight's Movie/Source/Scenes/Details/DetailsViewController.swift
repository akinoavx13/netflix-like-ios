//
//  DetailsViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: DetailsPresenterInput!

    // MARK: - Outlets -
    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = Colors.electromagnetic
        }
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var pictureImageView: UIImageView! {
        didSet {
            pictureImageView.contentMode = .scaleAspectFill
            pictureImageView.clipsToBounds = true
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        presenter.viewCreated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = Colors.electromagnetic
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.viewWillDisappear()
        backgroundImageView.cancelDownloadTask()
        pictureImageView.cancelDownloadTask()
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
    func display(_ displayModel: Details.DisplayData.DetailsFetched) {
        UIView.animate(withDuration: 0.2) {
            self.title = displayModel.title
            self.view.layoutIfNeeded()
        }
        
        backgroundImageView.setImage(url: "https://image.tmdb.org/t/p/w500\(displayModel.backgroundURL)")
        pictureImageView.setImage(url: "https://image.tmdb.org/t/p/w500\(displayModel.pictureURL)")
    }
    
    func display(_ displayModel: Details.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
