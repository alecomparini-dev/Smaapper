//
//  WhatFlowerCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/07/23.
//

import UIKit

class WhatFlowerCoordinator: Coordinator {
    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start(where component: UIView) {
        let controller = WhatBeerFloatViewController()
        controller.setCustomAttribute(WhatBeerFloatViewController.identifierApp)
        floatNavigationController.present(controller, where: component )
    }

    func start() {}
}
