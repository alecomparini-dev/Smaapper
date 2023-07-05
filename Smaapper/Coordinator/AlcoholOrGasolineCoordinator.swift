//
//  AlcoholOrGasolineCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/07/23.
//

import UIKit

class AlcoholOrGasolineCoordinator: Coordinator {

    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start(where component: UIView) {
        let controller = AlcoholOrGasolineFloatViewController()
        controller.setCustomAttribute(AlcoholOrGasolineFloatViewController.identifierApp)
        floatNavigationController.present(controller, where: component )
    }

    func start() {}
    
}
