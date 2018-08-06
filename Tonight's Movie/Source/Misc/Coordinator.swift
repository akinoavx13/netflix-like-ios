//
//  Coordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    
    // MARK: - Properties -
    var children: [Coordinator] { get set }
    
    // MARK: - Methods -
    func start()
}
