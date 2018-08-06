//
//  AppCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//Copyright © 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    // MARK: - Properties -
    let window: UIWindow
    var children: [Coordinator]

    // MARK: - Lifecycle -
    init(window: UIWindow) {
        self.window = window
        self.children = []
    }

    // MARK: - Methods -
    func start() {
        // Perform initial application seutp.
        setupAfterLaunch()

        // Start your first flow here. For example, this is the
        // ideal place for deciding if you should show login or main flows.
        showMain()

        // Finally make the window key and visible.
        window.makeKeyAndVisible()
    }

    private func showMain() {
        let coordinator = TabBarCoordinator(window: window)
        children = [coordinator]
        coordinator.start()
    }

    private func setupAfterLaunch() {
        // Perform initial app setup after launch like analytics, integrations and more.
    }
}
