//
//  ProportionCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

class ProportionCoordinator: Coordinator {

    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start(where component: UIView) {
        let controller = ProportionFloatViewController()
        controller.setCustomAttribute(ProportionFloatViewController.identifierApp)
        floatNavigationController.present(controller, where: component )
    }

    func start() {}
    
}

