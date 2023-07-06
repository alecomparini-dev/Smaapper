//
//  ARNodeBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit
import ARKit

class ARNodeBuilder: SCNNode {
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - SET Properties
    
    @discardableResult
    func setGeometry(_ geometry: ARGeometryBuilder) -> Self {
        self.geometry = geometry.get
        return self
    }
    
    @discardableResult
    func setPosition(_ worldTransform: simd_float4x4?) -> Self {
        if let worldTransform {
            self.simdTransform = worldTransform
        }
        return self
    }
    
    @discardableResult
    func setAutoFollowCamera() -> Self {
        let billboardConstraint = SCNBillboardConstraint()
        self.constraints = [billboardConstraint]
        return self
    }
    
    
}
