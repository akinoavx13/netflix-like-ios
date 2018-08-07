//
//  ItemListViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 07/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: ItemListPresenterInput!

    // MARK: - Outlets -
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = Colors.black
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewCreated()
    }
    
    // MARK: - Methods -
    class func instantiate(with presenter: ItemListPresenterInput) -> ItemListViewController {
        let name = "\(ItemListViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! ItemListViewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Actions -
}

extension ItemListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ItemListCell.self)", for: indexPath) as? ItemListCell else { return UICollectionViewCell() }
        
        presenter.configure(item: cell, at: indexPath)
        
        return cell
    }
}

extension ItemListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.numberOfItems - 5 {
            presenter.displayNext()
        }
    }
    
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension ItemListViewController: ItemListPresenterOutput {
    func display(_ displayModel: ItemList.DisplayData.Items) {
        collectionView.reloadData()
    }
    
    func display(_ displayModel: ItemList.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
