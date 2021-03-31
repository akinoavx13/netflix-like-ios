//
//  ItemListPresenter.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Foundation

class ItemListPresenter {
    
    // MARK: - Properties -
    let interactor: ItemListInteractorInput
    weak var coordinator: ItemListCoordinatorInput?
    weak var output: ItemListPresenterOutput?

    private var items: [Item]
    
    // MARK: - Lifecycle -
    init(interactor: ItemListInteractorInput, coordinator: ItemListCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
        items = []
    }
    
    func update(items: [Item]) {
        self.items = items
        
        output?.display(ItemList.DisplayData.Items())
    }
}

// MARK: - User Events -

extension ItemListPresenter: ItemListPresenterInput {
    
    // MARK: - Properties -
    var numberOfItems: Int {
        return items.count
    }
    
    // MARK: - Methods -
    func viewCreated() {
        
    }
    
    func configure(_ cell: ItemListCellProtocol, at indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        cell.display(pictureURL: item.smallPictureUrl)
    }
    
    func didEndDisplaying(_ cell: ItemListCellProtocol) {
        cell.didEndDisplaying()
    }
    
    func showDetails(at indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        coordinator?.showDetailsOf(id: item.id, of: item.contentType)
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension ItemListPresenter: ItemListInteractorOutput {
    
}
