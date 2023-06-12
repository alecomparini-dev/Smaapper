//
//  RuleOfThreeCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

class RuleOfThreeCoordinator: Coordinator {

    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start(where component: UIView) {
        let weather = RuleOfThreeFloatViewController()
        weather.setCustomAttribute(RuleOfThreeFloatViewController.identifierApp)
        floatNavigationController.present(weather, where: component )
    }

    func start() {}
    
}

