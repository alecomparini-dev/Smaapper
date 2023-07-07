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
    var nodes: [ARNodeBuilder]?
    
    override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SALVE WORLD MAP
    func saveWorldMap(_ session: ARSession? = nil) {
        if let currentSession = getCurrentSession() {
            getCurrentWorldMap(currentSession) { [weak self] worldMap in
                guard let self else {return}
                convertWorldMapToData(worldMap)
            }
        }
    }
    

//  MARK: - PRIVATE Area
    
    private func getCurrentSession(_ session: ARSession? = nil) -> ARSession? {
        return (session == nil) ? self.session : session
    }
    
    private func getCurrentWorldMap(_ currentSession: ARSession, completion: @escaping (_ worldMap: ARWorldMap) -> Void) {
        currentSession.getCurrentWorldMap { [weak self] worldMap, error in
            guard let self else {return}
            if error != nil {
                delegateARScene?.saveWorldMap(nil, Error.worldMap(typeError: .getWordlMap , error: error!.localizedDescription))
                return
            }
            if let worldMap {
                completion(worldMap)
            }
        }
    }
    
    private func convertWorldMapToData(_ worldMap: ARWorldMap) {
        do {
            let worldMapData = try NSKeyedArchiver.archivedData(withRootObject: worldMap, requiringSecureCoding: true)
            delegateARScene?.saveWorldMap(worldMapData, nil)
        } catch {
            delegateARScene?.saveWorldMap(nil, Error.worldMap(typeError: .convertToData, error: error.localizedDescription))
        }
    }
    
}

//  MARK: - EXTENSION DELEGATE ARSessionDelegate

extension ARSceneView: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) { }
    
    func sessionWasInterrupted(_ session: ARSession) {
        saveWorldMap(session)
    }
}


//  MARK: - EXTENSION DELEGATE ARSCNViewDelegate

extension ARSceneView: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print(node)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: self) {
            delegateARScene?.positionTouch(touchLocation)
        }
    }
    
}

