//
//  TapeMeasureARKitView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import UIKit
import ARKit

protocol CameraARKitViewDelegate: AnyObject {
    func positionTouch(_ position: CGPoint)
}

class CameraARKitView: UIView {
    
    weak var delegate: CameraARKitViewDelegate?
    
    enum Alignment {
        case top
        case middle
        case bottom
    }
    
    private var enabledTouch: Bool = true
    private var positionTarget: CGPoint = .zero
    
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
   
    
//  MARK: - GET AREA
    
    func getPositionTarget() -> CGPoint? {
        if targetImage.view.isHidden { return nil }
        return targetImage.view.convert(targetBallImage.view.center, to: self)
    }

    
    
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
    
    func add(_ node: SCNNode) -> Self {
        sceneView.scene.rootNode.addChildNode(node)
        return self
    }

    
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
    
    private func addElements() {
        sceneView.add(insideTo: self)
        targetImage.add(insideTo: self)
        targetBallImage.add(insideTo: targetImage.view)
    }
    
    private func configConstraints() {
        configSceneViewConstraints()
        targetImage.applyConstraint()
        targetBallImage.applyConstraint()
    }
    
    private func configSceneViewConstraints() {
        sceneView.makeConstraints { make in
            make
                .setPin.equalToSuperView
                .apply()
        }
    }
    
    private func addDot(at castResult: ARRaycastResult) {
        let dotGeometry = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        material.diffuse.contents = Theme.shared.currentTheme.tertiary
        dotGeometry.materials = [material]
        let dotNode = SCNNode(geometry: dotGeometry)
        dotNode.simdTransform = castResult.worldTransform
//        setChildNode(dotNode)
    }
    
    
    
    private func addStickyNote(at castResult: ARRaycastResult) {
        let customView = UIView()

        let material = SCNMaterial()
        material.diffuse.contents = customView.convertToImage

        
        let planeGeometry = SCNPlane(width: 0.1, height: 0.1)
        planeGeometry.materials = [material]

        
        let planeNode = SCNNode(geometry: planeGeometry)

//        planeNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01) // Set the scale of the SCNPlane


        planeNode.simdTransform = castResult.worldTransform
        let billboardConstraint = SCNBillboardConstraint()
        planeNode.constraints = [billboardConstraint]
        
        sceneView.scene.rootNode.addChildNode(planeNode)
    }
    
    
        
    private func getPositionTouch(_ touches: Set<UITouch>) -> CGPoint {
        if let touchLocation = touches.first?.location(in: sceneView) {
            return touchLocation
        }
        return .zero
    }
    
    
}



//  MARK: - EXTENSION DELEGATE ARSCNViewDelegate
extension CameraARKitView: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        //TODO: - IMPLEMENT DETECT PLANE
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.positionTouch(getPositionTouch(touches))
        
        

        if let raycastQuery = sceneView.raycastQuery(from: positionTarget, allowing: .existingPlaneGeometry, alignment: .horizontal) {
            if let castResult = sceneView.session.raycast(raycastQuery).first {
                addDot(at: castResult)
                addStickyNote(at: castResult)
            }
        }
        
        if let raycastQuery = sceneView.raycastQuery(from: positionTarget, allowing: .estimatedPlane, alignment: .vertical) {
            if let castResult = sceneView.session.raycast(raycastQuery).first {
                addDot(at: castResult)
                addStickyNote(at: castResult)
            }
        }
        
    }
    
    
}
