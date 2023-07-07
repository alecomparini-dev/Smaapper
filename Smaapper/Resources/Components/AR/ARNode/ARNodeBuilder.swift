//
//  ARNodeBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit
import ARKit

class ARNodeBuilder: SCNNode {
    
    private(set) var anchor: ARAnchor?
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - SET Properties
    
    @discardableResult
    func setIdentifier(_ id: String) -> Self {
        self.name = id
        return self
    }
    
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
    
    @discardableResult
    func setAnchor(_ anchor: ARAnchor) -> Self {
        self.anchor = anchor
        return self
    }
    
    
}
