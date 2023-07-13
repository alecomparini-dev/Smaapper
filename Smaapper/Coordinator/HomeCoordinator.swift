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
        let controller = HomeViewController()
        controller.delegateFloatViewController = self
        floatNavigationController.pushViewController(controller, animated: true)
    }
    
}

extension HomeCoordinator: HomeFloatViewControllerDelegate {
    
    func openFloatViewController(_ idApp: String, where component: UIView) {
        
        switch idApp {
            
            case WeatherFloatViewController.identifierApp:
                let coodinator = WeatherCoordinator(floatNavigationController)
                coodinator.start(where: component)
                
            case ProportionFloatViewController.identifierApp:
                let coodinator = ProportionCoordinator(floatNavigationController)
                coodinator.start(where: component)
            
            case QuizFloatViewController.identifierApp:
                let coodinator = QuizCoordinator(floatNavigationController)
                coodinator.start(where: component)
            
            case UpcomingHolidaysFloatViewController.identifierApp:
                let coodinator = UpcomingHolidaysCoordinator(floatNavigationController)
                coodinator.start(where: component)
            
            case BMICalculatorFloatViewController.identifierApp:
                let coodinator = BMICalculatorCoordinator(floatNavigationController)
                coodinator.start(where: component)
            
            case CalculatorFloatViewController.identifierApp:
                let coodinator = CalculatorCoordinator(floatNavigationController)
                coodinator.start(where: component)
            
            case HangmanFloatViewController.identifierApp:
                let coodinator = HangmanCoordinator(floatNavigationController)
                coodinator.start(where: component)
            
            case TapeMeasureFloatViewController.identifierApp:
                let coodinator = TapeMeasureCoordinator(floatNavigationController)
                coodinator.start(where: component)
            
            case StickyNoteFloatViewController.identifierApp:
                let coodinator = StickyNoteCoordinator(floatNavigationController)
                coodinator.start(where: component)
            
            case AlcoholOrGasolineFloatViewController.identifierApp:
                let coodinator = AlcoholOrGasolineCoordinator(floatNavigationController)
                coodinator.start(where: component)

            case WhatBeerFloatViewController.identifierApp:
                let coodinator = WhatFlowerCoordinator(floatNavigationController)
                coodinator.start(where: component)

            default:
                let coodinator = WeatherCoordinator(floatNavigationController)
                coodinator.start(where: component)
        }
    }
    
}
