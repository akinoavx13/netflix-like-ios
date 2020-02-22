//
//  AppDelegate.swift
//  Netflix
//
//  Created by Maxime Maheo on 19/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    private lazy var mainWindow = UIWindow()

    private let router = AppCoordinator().strongRouter

    // MARK: - Methods
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        router.setRoot(for: mainWindow)

        return true
    }

}
