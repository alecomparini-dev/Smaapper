//
//  WeatherCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/06/23.
//

import UIKit

class WeatherCoordinator: Coordinator {

    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start(where component: UIView) {
        let controller = WeatherFloatViewController()
        controller.setCustomAttribute(WeatherFloatViewController.identifierApp)
        floatNavigationController.present(controller, where: component )
    }

    func start() {}
}
