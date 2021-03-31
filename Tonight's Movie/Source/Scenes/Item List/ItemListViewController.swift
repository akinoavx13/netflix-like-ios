//
//  ItemListViewController.swift
//  Tonight's Movie
//
//   07/08/2018.
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import UIKit

protocol ItemListViewControllerDelegate: class {
    func fetchNextItems(_ itemListViewController: ItemListViewController)
}

class ItemListViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: ItemListPresenterInput!
    
    weak var delegate: ItemListViewControllerDelegate?

    // MARK: - Outlets -
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = Colors.black
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(UINib(nibName: "ItemListCell", bundle: nil), forCellWithReuseIdentifier: "\(ItemListCell.self)")
            
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = Style.CollectionView.offset
            layout.minimumInteritemSpacing = Style.CollectionView.offset
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            layout.itemSize = Style.Cell.getItemSizeDefault
            
            collectionView.collectionViewLayout = layout
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
        
        presenter.configure(cell, at: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetails(at: indexPath)
    }
}

extension ItemListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.numberOfItems - 5 {
            delegate?.fetchNextItems(self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ItemListCell else { return }
        
        presenter.didEndDisplaying(cell)
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension ItemListViewController: ItemListPresenterOutput {
    func display(_ displayModel: ItemList.DisplayData.Items) {
        collectionView.reloadData()
    }
}
