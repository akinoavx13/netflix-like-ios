//
//  DiscoverViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: DiscoverPresenterInput!

    // MARK: - Outlets -
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = Colors.electromagnetic
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.electromagnetic
        
        presenter.viewCreated()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
    
}

extension DiscoverViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? presenter.numberOfMovies : presenter.numberOfTVShows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DiscoverCell.self)", for: indexPath) as? DiscoverCell else { return UICollectionViewCell() }
        
        presenter.configure(item: cell, at: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(DiscoverHeaderView.self)", for: indexPath) as! DiscoverHeaderView
            
            headerView.titleLabel.text = indexPath.section == 0 ? Translation.Discover.movies : Translation.Discover.tvShows
            
            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }
}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 2) - 24
        
        return CGSize(width: width, height: width * 1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 70)
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension DiscoverViewController: DiscoverPresenterOutput {
    func display(_ displayModel: Discover.DisplayData.Movies) {
        collectionView.reloadData()
    }
    
    func display(_ displayModel: Discover.DisplayData.TVShows) {
        collectionView.reloadData()
    }
    
    func display(_ displayModel: Discover.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
