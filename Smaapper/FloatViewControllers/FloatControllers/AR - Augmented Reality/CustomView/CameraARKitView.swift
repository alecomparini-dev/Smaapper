//
//  TapeMeasureARKitView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import UIKit
import ARKit

class CameraARKitView: UIView {
    
    enum Alignment {
        case top
        case middle
        case bottom
    }
    
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
    }
    

//  MARK: - LAZY Area
    lazy var targetImage: ImageViewBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: K.CameraARKit.Images.imageTarget))
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setSize(K.CameraARKit.sizeTarget)
            .setWeight(.thin)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView(-100)
                    .setHorizontalAlignmentX.equalToSuperView
            }
            .setActions { build in
                build
                    .setDraggable()
            }
        return img
    }()
    
    lazy var targetBallImage: ImageViewBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: K.CameraARKit.Images.imageBallTarget))
            .setTintColor(Theme.shared.currentTheme.onSurface.withAlphaComponent(0.8))
            .setSize(6)
            .setWeight(.thin)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
            }
        return img
    }()
   
    
//  MARK: - SET Properties
    @discardableResult
    func setDebug(_ debugOptions: ARSCNDebugOptions) -> Self {
        sceneView.debugOptions = debugOptions
        return self
    }
    
    @discardableResult
    func setEnabledTarget(_ enabled: Bool) -> Self {
        self.targetImage.setHidden(!enabled)
        return self
    }
    
    @discardableResult
    func setEnabledTargetDraggable(_ enabled: Bool) -> Self {
        self.targetImage.actions?.draggable?.setEnabledDraggable(enabled)
        return self
    }
    
    @discardableResult
    func setChildNode(_ node: SCNNode) -> Self {
        sceneView.scene.rootNode.addChildNode(node)
        return self
    }
    
    @discardableResult
    func setAlignmentTarget(_ alignment: Alignment, _ padding: CGFloat = 0) -> Self {
        DispatchQueue.main.async { [weak self] in
            self?.setAligment(alignment, padding)
        }
        return self
    }

    @discardableResult
    func setImageTarget(_ img: ImageViewBuilder, _ size: CGFloat = K.CameraARKit.sizeTarget) -> Self {
        self.targetImage.setImage(img.view.image)
        self.targetBallImage.setHidden(true)
        targetImage.setSize(size)
        return self
    }
    
    
//  MARK: - ACTIONS
    func runSceneView(){
        sceneView.session.run(configuration)
    }
    
    func pauseSceneView() {
        sceneView.session.pause()
    }
    
    
//  MARK: - PRIVATE Area
    private func setAligment(_ alignment: Alignment, _ padding: CGFloat) {
        switch alignment {
            case .top:
                self.targetImage.view.frame.origin.y = self.bounds.minY + padding
            case .middle:
                self.targetImage.view.center.y = (self.bounds.midY) + padding
            case .bottom:
                self.targetImage.view.frame.origin.y = (self.bounds.maxY - self.targetImage.view.bounds.height) - padding
        }
    }
    
    private func createSceneView() {
        sceneView = ARSCNView(frame: self.bounds)
    }
    
    private func configSceneView() {
        setConfiguration()
        setEnabledTarget(true)
        setEnabledTargetDraggable(true)
    }
    
    private func setConfiguration() {
        configuration = ARWorldTrackingConfiguration()
         configuration.planeDetection = [.horizontal, .vertical]
    }
    
    private func configDelegate() {
        sceneView.delegate = self
    }
    
    private func configCornerRadius() {
//        setCornerRadiusSelf()
    }
    
    private func setCornerRadiusSelf() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
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
    
    private func getPositionTarget(_ touches: Set<UITouch>) -> CGPoint{
        if targetImage.view.isHidden {
            if let touchLocation = touches.first?.location(in: sceneView) {
                return touchLocation
            }
        }
        return targetImage.view.convert(targetBallImage.view.center, to: self)
    }
    
    private func addDot(at castResult: ARRaycastResult) {
        let dotGeometry = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        material.diffuse.contents = Theme.shared.currentTheme.tertiary
        dotGeometry.materials = [material]
        let dotNode = SCNNode(geometry: dotGeometry)
        dotNode.simdTransform = castResult.worldTransform
        
        setChildNode(dotNode)
    }

    
}


//  MARK: - EXTENSION DELEGATE ARSCNViewDelegate
extension CameraARKitView: ARSCNViewDelegate {
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let positionTarget: CGPoint = getPositionTarget(touches)
        
        if let raycastQuery = sceneView.raycastQuery(from: positionTarget, allowing: .existingPlaneGeometry, alignment: .horizontal) {
            if let castResult = sceneView.session.raycast(raycastQuery).first {
                addDot(at: castResult)
            }
        }
        
        if let raycastQuery = sceneView.raycastQuery(from: positionTarget, allowing: .estimatedPlane, alignment: .vertical) {
            if let castResult = sceneView.session.raycast(raycastQuery).first {
                addDot(at: castResult)
            }
        }
    
    }
    
    
}
