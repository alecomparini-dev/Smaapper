//
//  TapeMeasureCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import UIKit

class TapeMeasureCoordinator: Coordinator {

    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start(where component: UIView) {
        let controller = TapeMeasureFloatViewController()
        controller.setCustomAttribute(TapeMeasureFloatViewController.identifierApp)
        floatNavigationController.present(controller, where: component )
    }

    func start() {}
}

