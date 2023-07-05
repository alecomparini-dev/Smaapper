//
//  ARSceneView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit
import ARKit

protocol ARSceneViewDelegate: AnyObject {
    func positionTouch(_ position: CGPoint)
}

class ARSceneView: ARSCNView {
    weak var delegateARScene: ARSceneViewDelegate?
    
    var configuration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    
    override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//  MARK: - EXTENSION DELEGATE ARSCNViewDelegate

extension ARSceneView: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        //TODO: - IMPLEMENT DETECT PLANE
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: self) {
            delegateARScene?.positionTouch(touchLocation)
        }
    }
    
}

