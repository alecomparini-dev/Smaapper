//
//  Coordinator.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/06/23.
//

import UIKit

protocol Coordinator {
    var floatNavigationController: FloatNavigationController { get }
    
    init(_ floatNavigationController: FloatNavigationController)
    
    func start()
    
    func start(where: UIView)
}

extension Coordinator {
    func start(where: UIView) {}
}
