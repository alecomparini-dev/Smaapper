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
    func saveWorldMap(_ worldMap: Data?, _ error: Error?)
}

class ARSceneView: ARSCNView {
    weak var delegateARScene: ARSceneViewDelegate?
    
    var worldMap: ARWorldMap?
    var configuration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    
    override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func saveWorldMap(_ session: ARSession? = nil) {
        let currentSession = (session == nil) ? self.session : session
        
        if let currentSession {
            currentSession.getCurrentWorldMap { [weak self] worldMap, error in
                guard let self else {return}
                if error != nil {
                    delegateARScene?.saveWorldMap(nil, Error.worldMap(typeError: .getWordlMap, error: error!.localizedDescription))
                    return
                }
                guard let worldMap else {return}
                do {
                    let worldMapData = try NSKeyedArchiver.archivedData(withRootObject: worldMap, requiringSecureCoding: true)
                    delegateARScene?.saveWorldMap(worldMapData, nil)
                } catch {
                    delegateARScene?.saveWorldMap(nil, Error.worldMap(typeError: .convertToData, error: error.localizedDescription))
                }
            }
        }
    }
    
}


//  MARK: - EXTENSION DELEGATE ARSCNViewDelegate

extension ARSceneView: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) { }
    
    func sessionWasInterrupted(_ session: ARSession) {
        saveWorldMap(session)
    }
}

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
