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
            
            let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
            
            textFieldInsideSearchBar?.textColor = Colors.grey
            textFieldInsideSearchBar?.backgroundColor = Colors.lightBlack
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = Colors.black
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.2) {
            searchBar.showsCancelButton = true
            searchBar.text = ""
            
            self.view.layoutIfNeeded()
        }
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.2) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            
            self.view.layoutIfNeeded()
        }
        
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
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

}
