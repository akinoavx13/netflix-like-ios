//
//  BookmarksViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: BookmarksPresenterInput!

    // MARK: - Outlets -
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = Colors.black
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsVerticalScrollIndicator = false
            collectionView.register(UINib(nibName: "ItemListCell", bundle: nil), forCellWithReuseIdentifier: "\(ItemListCell.self)")
            collectionView.register(UINib(nibName: "SearchHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(SearchHeaderView.self)")
            
            
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = Style.CollectionView.offset
            layout.minimumInteritemSpacing = Style.CollectionView.offset
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            layout.itemSize = Style.Cell.getItemSizeLarge
            layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
            
            collectionView.collectionViewLayout = layout
        }
    }
    
    @IBOutlet weak var emptyStateLabel: UILabel! {
        didSet {
            emptyStateLabel.text = Translation.Bookmarks.noBookmark
            emptyStateLabel.textColor = Colors.white
            emptyStateLabel.font = Fonts.small
            emptyStateLabel.numberOfLines = 2
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewCreated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.viewWillDisappear()
    }
    
    // MARK: - Methods -
    class func instantiate(with presenter: BookmarksPresenterInput) -> BookmarksViewController {
        let name = "\(BookmarksViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! BookmarksViewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Actions -
}

extension BookmarksViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSavedItems == 0 ? 0 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return presenter.numberOfSavedItems
        } else if section == 1 {
            return presenter.numberOfRecommendedMovies
        } else if section == 2 {
            return presenter.numberOfRecommendedTVShows
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ItemListCell.self)", for: indexPath) as? ItemListCell else { return UICollectionViewCell() }
        
        presenter.configure(item: cell, at: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(SearchHeaderView.self)", for: indexPath) as? SearchHeaderView else { return UICollectionReusableView() }
            
            presenter.configure(item: headerView, at: indexPath)
            
            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetails(at: indexPath)
    }
}

extension BookmarksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ItemListCell else { return }
        
        presenter.didEndDisplaying(item: cell, at: indexPath)
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension BookmarksViewController: BookmarksPresenterOutput {
    func display(_ displayModel: Bookmarks.DisplayData.Items) {
        collectionView.reloadData()
        
        if presenter.numberOfSavedItems == 0 {
            UIView.animate(withDuration: Style.Animation.duration) {
                self.emptyStateLabel.alpha = 1
                
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: Style.Animation.duration) {
                self.emptyStateLabel.alpha = 0
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func display(_ displayModel: Bookmarks.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
