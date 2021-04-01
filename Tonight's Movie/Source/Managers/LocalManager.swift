//
//  LocalManager.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
//

import Cache

protocol HasLocalManager {
    var localManager: LocalManagerProtocol { get }
}

protocol LocalManagerProtocol {
    func save(item: Item)
    func getItems() -> [Item]
    func isPresent(item: Item) -> Bool
    func remove(item: Item)
}

final class LocalManager {
    
    // MARK: - Properties -
    private let storage: Storage<String, [Item]>?
    
    // MARK: - Lifecycle -
    init() {
        storage = try? Storage(
            diskConfig: DiskConfig(name: "items"),
            memoryConfig: MemoryConfig(expiry: .never, countLimit: 25, totalCostLimit: 25),
            transformer: TransformerFactory.forCodable(ofType: [Item].self)
        )
    }
    
    // MARK: - Methods -
    private func itemExists(item: Item, items: [Item]) -> Bool {
        return items.filter {
            return $0.id == item.id
        }.count > 0
    }
}

extension LocalManager: LocalManagerProtocol {
    func save(item: Item) {
        guard let storage = storage else { return }
        
        var items = getItems()
        
        if !itemExists(item: item, items: items) {
            items.append(item)
            try? storage.setObject(items, forKey: "items")
        }        
    }
    
    func getItems() -> [Item] {
        guard let storage = storage else { return [] }
                
        do {
            return try storage.object(forKey: "items")
        } catch {
            return []
        }
    }
    
    func isPresent(item: Item) -> Bool {
        return itemExists(item: item, items: getItems())
    }
    
    func remove(item: Item) {
        guard let storage = storage else { return }
        
        let items = getItems()
        try? storage.removeAll()
        
        _ = items.filter {
            return $0.id != item.id
        }.map{
            return save(item: $0)
        }
    }
}
