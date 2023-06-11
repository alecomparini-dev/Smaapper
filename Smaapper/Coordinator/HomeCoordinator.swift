//
//  HomeCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/06/23.
//

import UIKit


class HomeCoordinator: Coordinator {
    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.delegateFloatViewController = self
        floatNavigationController.pushViewController(homeViewController, animated: true)
    }
    
}

extension HomeCoordinator: HomeFloatViewControllerDelegate {
    func openFloatViewController(_ idApp: String, where component: UIView) {
        switch idApp {
            case WeatherFloatViewController.identifierApp:
                let coodinator = WeatherCoordinator(floatNavigationController)
                coodinator.start(where: component)
                
            default:
            let coodinator = WeatherCoordinator(floatNavigationController)
            coodinator.start(where: component)
        }
    }
    
}