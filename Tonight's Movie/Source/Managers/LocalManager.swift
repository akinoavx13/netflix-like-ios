//
//  LocalManager.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 09/08/2018.
//  Copyright © 2018 Maxime Maheo. All rights reserved.
//

import Cache

protocol HasLocalManager {
    var localManager: LocalManagerProtocol { get }
}

protocol LocalManagerProtocol {
    func save(item: Item)
    func getItems() -> [Item]
}

final class LocalManager {
    
    // MARK: - Properties -
    private let storage: Storage<[Item]>?
    
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
}
