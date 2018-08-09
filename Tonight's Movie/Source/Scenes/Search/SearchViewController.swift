//
//  SearchViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: SearchPresenterInput!

    // MARK: - Outlets -
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.barTintColor = Colors.black
            searchBar.tintColor = Colors.grey
            searchBar.delegate = self
            searchBar.placeholder = Translation.Search.search
            
            let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
            
            textFieldInsideSearchBar?.textColor = Colors.grey
            textFieldInsideSearchBar?.backgroundColor = Colors.lightBlack
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = Colors.black
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsVerticalScrollIndicator = false
            collectionView.register(UINib(nibName: "ItemListCell", bundle: nil), forCellWithReuseIdentifier: "\(ItemListCell.self)")
            collectionView.register(UINib(nibName: "SearchHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(SearchHeaderView.self)")
        }
    }
    
    @IBOutlet weak var emptyStateLabel: UILabel! {
        didSet {
            emptyStateLabel.text = Translation.Search.searchMovieOrTVShow
            emptyStateLabel.textColor = Colors.white
            emptyStateLabel.font = Fonts.small
            emptyStateLabel.numberOfLines = 2
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.black
        
        
        presenter.viewCreated()
    }
    
    // MARK: - Methods -
    class func instantiate(with presenter: SearchPresenterInput) -> SearchViewController {
        let name = "\(SearchViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! SearchViewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Actions -
}

extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numberOfSections = 0
        
        if presenter.numberOfMovies > 0 {
            numberOfSections += 1
        }
        
        if presenter.numberOfTVShows > 0 {
            numberOfSections += 1
        }
        
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? presenter.numberOfMovies : presenter.numberOfTVShows
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

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ItemListCell else { return }
        
        presenter.didEndDisplaying(item: cell, at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let witdh = UIScreen.main.bounds.width / 3 - 8
        
        return CGSize(width: witdh, height: witdh * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.2) {
            searchBar.showsCancelButton = true
            
            self.view.layoutIfNeeded()
        }
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.2) {
            searchBar.showsCancelButton = false
            
            self.view.layoutIfNeeded()
        }
        
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            presenter.search(with: searchText)
        } else {
            presenter.displayEmptyState()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension SearchViewController: SearchPresenterOutput {
    func display(_ displayModel: Search.DisplayData.Items) {
        collectionView.reloadData()
        
        if !(searchBar.text?.isEmpty ?? false) && presenter.numberOfMovies + presenter.numberOfTVShows == 0 {
            UIView.animate(withDuration: 0.2) {
                self.emptyStateLabel.alpha = 1
                self.emptyStateLabel.text = Translation.Search.noResult
                
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.emptyStateLabel.alpha = 0
                
                self.view.layoutIfNeeded()
            }
        }
        
        if searchBar.text?.isEmpty ?? false {
            UIView.animate(withDuration: 0.2) {
                self.emptyStateLabel.alpha = 1
                self.emptyStateLabel.text = Translation.Search.searchMovieOrTVShow
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func display(_ displayModel: Search.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
