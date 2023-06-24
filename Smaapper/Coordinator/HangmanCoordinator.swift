//
//  HangmanCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

class HangmanCoordinator: Coordinator {

    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start(where component: UIView) {
        let controller = HangmanFloatViewController()
        controller.setCustomAttribute(HangmanFloatViewController.identifierApp)
        floatNavigationController.present(controller, where: component )
    }

    func start() {}
}
