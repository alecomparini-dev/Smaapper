//
//  ARPlaneBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit
import ARKit

class ARPlaneBuilder: SCNPlane {
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SET Area
    @discardableResult
    func setSize(_ width: CGFloat, _ height: CGFloat) -> Self {
        self.width = width
        self.height = height
        return self
    }
    
}
