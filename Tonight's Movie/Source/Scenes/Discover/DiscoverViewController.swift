//
//  DiscoverViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: DiscoverPresenterInput!

    // MARK: - Outlets -
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = Colors.black
            tableView.tableFooterView = UIView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.rowHeight = 200
        }
    }
    
    @IBOutlet weak var highestRatedMovieImageView: UIImageView! {
        didSet {
            highestRatedMovieImageView.contentMode = .scaleAspectFill
            highestRatedMovieImageView.clipsToBounds = true
            highestRatedMovieImageView.isUserInteractionEnabled = true
            highestRatedMovieImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(highestRatedMovieImageViewTapped)))
        }
    }
    
    @IBOutlet weak var highestRatedMovieTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var gradientView: UIView! {
        didSet {
            gradientView.backgroundColor = .clear
            gradientView.isUserInteractionEnabled = true
            gradientView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(highestRatedMovieImageViewTapped)))
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highestRatedMovieTopConstraint.constant = -UIApplication.shared.statusBarFrame.height
        
        presenter.viewCreated()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        highestRatedMovieImageView.kf.cancelDownloadTask()
        
        presenter.viewWillDisappear()
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
    @objc
    private func highestRatedMovieImageViewTapped() {
        presenter.showHighestRatedMovieDetails()
    }
}

extension DiscoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(DiscoverCell.self)", for: indexPath) as? DiscoverCell else { return UITableViewCell() }
        
        presenter.configure(item: cell, at: indexPath)
        
        return cell
    }
}

extension DiscoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? DiscoverCell else { return }

        presenter.willDisplay(viewController: self, for: cell, at: indexPath)
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !cell.isKind(of: DiscoverCell.self) { return }
        
        presenter.didEndDisplaying(at: indexPath)
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension DiscoverViewController: DiscoverPresenterOutput {
    func display(_ displayModel: Discover.DisplayData.ForwardedItem) {
        if let url = URL(string: displayModel.pictureURL) {
            self.highestRatedMovieImageView.kf.setImage(with: url)
        }
        
        gradientView.gradient(colors: [UIColor.clear.cgColor, Colors.black.cgColor])
    }
    
    func display(_ displayModel: Discover.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
