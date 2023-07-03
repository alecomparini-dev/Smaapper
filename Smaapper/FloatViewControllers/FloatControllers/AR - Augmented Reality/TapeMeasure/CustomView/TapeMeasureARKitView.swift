//
//  TapeMeasureARKitView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import UIKit
import ARKit

class TapeMeasureARKitView: UIView {
    
    private var dotNodes: [SCNNode] = []
    
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
        createSceneView()
        configSceneView()
        addElements()
        configConstraints()
        configCornerRadius()
        runSceneView()
        configDelegate()
//        configDebug()
    }
    

//  MARK: - LAZY Area
    lazy var targetImage: ImageViewBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "viewfinder"))
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setSize(50)
            .setWeight(.thin)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView(-100)
                    .setHorizontalAlignmentX.equalToSuperView
            }
        return img
    }()
    
    lazy var targetBallImage: ImageViewBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "circle.fill"))
            .setTintColor(Theme.shared.currentTheme.onSurface.withAlphaComponent(0.8))
            .setSize(6)
            .setWeight(.thin)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
            }
        return img
    }()
    
    
    private func configDebug() {
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    
//  MARK: - ACTIONS
    func runSceneView(){
        sceneView.session.run(configuration)
    }
    
    func pauseSceneView() {
        sceneView.session.pause()
    }
    
//  MARK: - PRIVATE Area
    private func createSceneView() {
        sceneView = ARSCNView(frame: self.bounds)
    }
    
    private func configSceneView() {
        configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
    }
    
    private func configDelegate() {
        DispatchQueue.main.async { [weak self] in
            self?.sceneView.delegate = self
        }
    }
    
    private func configCornerRadius() {
        setCornerRadiusSelf()
        setCornerRadiusSceneView()
    }
    
    private func setCornerRadiusSelf() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    private func setCornerRadiusSceneView() {
        sceneView.layer.cornerRadius = 20
        sceneView.clipsToBounds = true
    }
    
    private func addElements() {
        sceneView.add(insideTo: self)
        targetImage.add(insideTo: self)
        targetBallImage.add(insideTo: targetImage.view)
    }
    
    private func configConstraints() {
        StartOfConstraintsFlow(sceneView)
            .setPin.equalToSuperView
            .apply()
        targetImage.applyConstraint()
        targetBallImage.applyConstraint()
    }
    
}


//  MARK: - EXTENSION DELEGATE ARSCNViewDelegate
extension TapeMeasureARKitView: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("detectou")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        let positionTarget = targetImage.view.convert(targetBallImage.view.center, to: self)
        
        if let raycastQuery = sceneView.raycastQuery(from: positionTarget, allowing: .existingPlaneGeometry, alignment: .any) {
            if let hitResult = sceneView.session.raycast(raycastQuery).first {
                addDot(at: hitResult)
            }
        }
        
//        if let raycastQuery = sceneView.raycastQuery(from: positionTarget, allowing: .existingPlaneGeometry, alignment: .vertical) {
//            if let hitResult = sceneView.session.raycast(raycastQuery).first {
//                addDot(at: hitResult)
//            }
//        }
    
    }
    
    private func addDot(at hitResult: ARRaycastResult) {
        let dotGeometry = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        material.diffuse.contents = Theme.shared.currentTheme.tertiary
        
        dotGeometry.materials = [material]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        
        dotNode.simdTransform = hitResult.worldTransform
        
        sceneView.scene.rootNode.addChildNode(dotNode)
    }
    
}
