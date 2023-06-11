//
//  NavigationFloatController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/06/23.
//

import UIKit

class FloatNavigationController: UINavigationController {
    
    func present(_ floatViewController: FloatViewController, where component: UIView,  completion: (() -> Void)? = nil) {
        floatViewController.present(insideTo: component)
    }

    
    func pushViewController(_ viewController: FloatViewController, animated: Bool) {
        print("aqui é o PUSHVIEWW !!")
    }

    
}
