//
//  CalculatorCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/06/23.
//

import UIKit

class CalculatorCoordinator: Coordinator {

    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start(where component: UIView) {
        let controller = CalculatorFloatViewController()
        controller.setCustomAttribute(CalculatorFloatViewController.identifierApp)
        floatNavigationController.present(controller, where: component )
    }

    func start() {}
    
}

