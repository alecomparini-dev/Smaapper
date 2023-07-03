//
//  StickyNoteCoordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 03/07/23.
//

import UIKit

class StickyNoteCoordinator: Coordinator {

    var floatNavigationController: FloatNavigationController
    
    required init(_ floatNavigationController: FloatNavigationController) {
        self.floatNavigationController = floatNavigationController
    }
    
    func start(where component: UIView) {
        let controller = StickyNoteFloatViewController()
        controller.setCustomAttribute(StickyNoteFloatViewController.identifierApp)
        floatNavigationController.present(controller, where: component )
    }

    func start() {}
}
