//
//  TapeMeasureARKitView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import UIKit
import ARKit

class TapeMeasureARKitView: UIView {
    
    private var configuration: ARWorldTrackingConfiguration!
    private(set) var sceneView: ARSCNView!
    
    init() {
        super.init(frame: .zero)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }
    
    private func initialization() {
        createScene()
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        addElements()
        configConstraints()
    }
    
    private func createScene() {
        sceneView = ARSCNView(frame: self.bounds)
        sceneView.delegate = self

        sceneView.layer.cornerRadius = 20
        sceneView.clipsToBounds = true
        
        runSceneView
    }
    
    var runSceneView: Void {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        return
    }
    
    var pauseSceneView: Void {
        sceneView.session.pause()
        return
    }
    
    
    
    private func addElements() {
        sceneView.add(insideTo: self)
    }
    
    private func configConstraints() {
        StartOfConstraintsFlow(sceneView)
            .setPin.equalToSuperView
            .apply()
    }
    
}


extension TapeMeasureARKitView: ARSCNViewDelegate {
    
}
