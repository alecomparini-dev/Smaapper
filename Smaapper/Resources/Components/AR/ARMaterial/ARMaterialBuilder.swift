//
//  ARMaterialBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit
import ARKit


class ARMaterialBuilder: SCNMaterial {
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - SET Properties
    
    @discardableResult
    func setDiffuseTexture(_ contents: Any ) -> Self {
        self.diffuse.contents = contents
        return self
    }
    
    

}
