//
//  SearchViewController.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.viewWillDisappear()
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
        return presenter.numberOfMovies + presenter.numberOfTVShows == 0 ? 0 : 2
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: Style.Animation.duration) {
            searchBar.showsCancelButton = true
            
            self.view.layoutIfNeeded()
        }
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: Style.Animation.duration) {
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
            UIView.animate(withDuration: Style.Animation.duration) {
                self.emptyStateLabel.alpha = 1
                self.emptyStateLabel.text = Translation.Search.noResult
                
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: Style.Animation.duration) {
                self.emptyStateLabel.alpha = 0
                
                self.view.layoutIfNeeded()
            }
        }
        
        if searchBar.text?.isEmpty ?? false {
            UIView.animate(withDuration: Style.Animation.duration) {
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
