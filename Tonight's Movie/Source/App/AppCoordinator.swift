//
//  AppCoordinator.swift
//  Tonight's Movie
//
// Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
