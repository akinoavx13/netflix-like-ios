//
//  MoviesViewController.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: MoviesViewModelContract?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Methods
    func bind(to viewModel: MoviesViewModelContract) {
        self.viewModel = viewModel
    }
}
