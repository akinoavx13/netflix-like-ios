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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ItemListCell.self)", for: indexPath) as? ItemListCell else { return UICollectionViewCell() }
        
        presenter.configure(item: cell, at: indexPath)
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ItemListCell else { return }
        
        presenter.didEndDisplaying(item: cell, at: indexPath)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let witdh = UIScreen.main.bounds.width / 3 - 8
        
        return CGSize(width: witdh, height: witdh * 1.5)
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
        if searchText.count > 3 {
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
    func display(_ displayModel: Search.DisplayData.Movies) {
        collectionView.reloadData()
    }
    
    func display(_ displayModel: Search.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
