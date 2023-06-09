//
//  NavigationFloatController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/06/23.
//

import UIKit

class NavigationFloatController: UINavigationController {
    
    
    func present(floatViewController: FloatViewController, insideTo: UIView, completion: (() -> Void)? = nil) {
        floatViewController.present(insideTo: insideTo)
    }

    
    func pushViewController(_ viewController: FloatViewController, animated: Bool) {
        print("aqui é o PUSHVIEWW !!")
    }

    
}

