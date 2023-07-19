//
//  CategoriesCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/07/23.
//

import UIKit

class CategoriesCoordinator: Coordinator {
    
    var floatNavigationController: FloatNavigationController
    
    private var categories: DropdownMenuData?
    private weak var controllerDelegate: CategoriesViewControllerDelegate?

    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    init(_ floatNavigationController: FloatNavigationController, categories: DropdownMenuData, controllerDelegate: CategoriesViewControllerDelegate) {
        self.floatNavigationController = floatNavigationController
        self.categories = categories
        self.controllerDelegate = controllerDelegate
    }

    func start() {
        guard let categories, let controllerDelegate else {return}
        let viewController = CategoriesViewController(categories)
        viewController.delegate = controllerDelegate
        viewController.modalPresentationStyle = .fullScreen
        self.floatNavigationController.present(viewController, animated: true)
    }
    
}
