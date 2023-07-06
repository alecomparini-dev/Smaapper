//
//  ARSphereBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit
import ARKit

class ARSphereBuilder: SCNSphere {
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SET Area
    @discardableResult
    func setRadius(_ radius: CGFloat) -> Self {
        self.radius = radius
        return self
    }
    
}
