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
    func anchorsWorldMap(_ anchors: [ARAnchor])
}

class ARSceneView: ARSCNView {
    weak var delegateARScene: ARSceneViewDelegate?
    
    var options: ARSession.RunOptions = []
    var configuration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    var nodes: [ARNodeBuilder] = []
    
    override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: nil)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SALVE WORLD MAP
    func saveWorldMap(completion: (() -> Void)? = nil) {
        self.session.getCurrentWorldMap { worldMap, error in
            guard let map = worldMap
            else { self.delegateARScene?.saveWorldMap(nil, Error.worldMap(typeError: .getWordlMap , error: "Nao tem worldMap\(error!.localizedDescription)"))
                completion?()
                return }

            do {
                let worldMapData = try NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                self.delegateARScene?.saveWorldMap(worldMapData, nil)
            } catch {
                self.delegateARScene?.saveWorldMap(nil, Error.worldMap(typeError: .convertToData, error: "Nao converteu para Data\(error.localizedDescription)"))
            }
            completion?()
        }
    }
    

//  MARK: - PRIVATE Area
    
    private func getCurrentWorldMap(_ currentSession: ARSession, completion: @escaping (_ worldMap: ARWorldMap) -> Void) {
        
    }

    private func getCurrentSession(_ session: ARSession? = nil) -> ARSession? {
        return (session == nil) ? self.session : session
    }
    

}

//  MARK: - EXTENSION DELEGATE ARSessionDelegate

extension ARSceneView: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("session.identifier:", session.identifier)
        print("camera.trackingState:", camera.trackingState)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        saveWorldMap()
    }
}


//  MARK: - EXTENSION DELEGATE ARSCNViewDelegate

extension ARSceneView: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print(anchor.identifier)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: self) {
            delegateARScene?.positionTouch(touchLocation)
        }
    }
    
}

