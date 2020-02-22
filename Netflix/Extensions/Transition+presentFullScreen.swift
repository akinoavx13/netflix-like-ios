//
//  Transition+presentFullScreen.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import XCoordinator

extension Transition {

    static func presentFullScreen(
        _ presentable: Presentable,
        animation: Animation? = nil
    )
        -> Transition
    {
        presentable.viewController?.modalPresentationStyle = .fullScreen
        return .present(presentable, animation: animation)
    }

}
