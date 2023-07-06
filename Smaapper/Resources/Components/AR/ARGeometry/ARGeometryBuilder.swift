//
//  ARGeometryBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit
import ARKit

class ARGeometryBuilder {
    
    private var _geometry: SCNGeometry?
    

//  MARK: - GET Properties
    var get: SCNGeometry? { _geometry }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setPlane(_ geometry: (_ build: ARPlaneBuilder) -> ARPlaneBuilder) -> Self {
        _geometry = geometry(ARPlaneBuilder())
        return self
    }
    
    @discardableResult
    func setSphere(_ geometry: (_ build: ARSphereBuilder) -> ARSphereBuilder) -> Self {
        _geometry = geometry(ARSphereBuilder())
        return self
    }
    
    @discardableResult
    func setMaterial(_ material: ARMaterialBuilder, _ at: Int = 0) -> Self {
        if let _geometry {
            _geometry.materials.insert(material, at: at)
        }
        return self
    }
    
    
}
