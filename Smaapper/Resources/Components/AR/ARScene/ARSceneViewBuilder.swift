//
//  ARSceneViewBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit
import ARKit
import SceneKit


class ARSceneViewBuilder: ViewBuilder {
    
    private var arSceneView: ARSceneView!
    
    enum Alignment {
        case top
        case middle
        case bottom
    }
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        createSceneView()
        configSceneView()
        addElements()
        configConstraints()
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
    
    
//  MARK: - GET Area
    var nodes: [ARNodeBuilder] {
        get { arSceneView.nodes }
        set { arSceneView.nodes = newValue}
    }
    
    func getPositionOnPlaneByTouch(positionTouch: CGPoint, _ alignment: ARRaycastQuery.TargetAlignment) -> ARRaycastResult? {
        if let raycastQuery = arSceneView.raycastQuery(from: positionTouch, allowing: .existingPlaneGeometry, alignment: alignment) {
            if let castResult = arSceneView.session.raycast(raycastQuery).first {
                return castResult
            }
        }
        return nil
    }
    
    func getPositionOnPlaneByTarget(_ alignment: ARRaycastQuery.TargetAlignment) -> ARRaycastResult? {
        let positionTarget: CGPoint = targetImage.view.convert(targetBallImage.view.center, to: arSceneView)
        return getPositionOnPlaneByTouch(positionTouch: positionTarget, alignment)
    }
    
    func getPositionByCam(centimetersAhead: Float? = 0) -> simd_float4x4? {
        if let cameraTransform = arSceneView.session.currentFrame?.camera.transform {
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -((centimetersAhead ?? 0.0) / 100.0)
            return matrix_multiply(cameraTransform, translation)
        }
        return nil
    }
    
    
//  MARK: - SET Properties

    @discardableResult
    func setPlaneDetection(_ planeDetection: ARWorldTrackingConfiguration.PlaneDetection) -> Self {
        arSceneView.configuration.planeDetection = planeDetection
        return self
    }

    @discardableResult
    func setDebug(_ debugOptions: ARSCNDebugOptions) -> Self {
        arSceneView.debugOptions = debugOptions
        return self
    }
    
    @discardableResult
    func setEnabledTarget(_ enabled: Bool) -> Self {
        targetImage.setHidden(!enabled)
        return self
    }
    
    @discardableResult
    func setOptions(_ options: ARSession.RunOptions) -> Self {
        arSceneView.options.insert(options)
        return self
    }
    
    @discardableResult
    func setEnabledTargetDraggable(_ enabled: Bool) -> Self {
        targetImage.actions?.draggable?.setEnabledDraggable(enabled)
        return self
    }
    
    @discardableResult
    func setAlignmentTarget(_ alignment: Alignment, _ padding: CGFloat = 0) -> Self {
        DispatchQueue.main.async { [weak self] in
            self?.setAlignment(alignment, padding)
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
    
    
//  MARK: - DELEGATE
    
    @discardableResult
    func setDelegate(_ delegate: ARSceneViewDelegate) -> Self {
        arSceneView.delegateARScene = delegate
        return self
    }

    
//  MARK: - ACTIONS
    
    func runSceneView(_ worldMapData: Data? = nil) {
        if let worldMapData {
            if let worldMap = tryConvertDataToWorldMap(worldMapData) {
                let newWorldMap = worldMap
                arSceneView.configuration.initialWorldMap = worldMap
                arSceneView.session.run(arSceneView.configuration, options: [.resetTracking, .removeExistingAnchors])
                resetAnchorsInWorldMap(worldMap)
                sendAnchorsOnWorldMap(newWorldMap)
                return
            }
        }
        arSceneView.session.run(arSceneView.configuration, options: arSceneView.options)
    }

    func pauseSceneView() {
        arSceneView.currentSession = arSceneView.session
        arSceneView.saveWorldMap() { [weak self] in
            guard let self else {return}
            resetNodes()
            return
        }
        arSceneView.session.pause()
    }
    
    private func resetNodes() {
        arSceneView.nodes.forEach({ node in
            removeNode(node)
        })
        arSceneView.nodes = []
    }

    private func resetAnchorsInWorldMap( _ worldMap: ARWorldMap) {
        print("DELETANDO OS ANCHORS QUE EXISTE", worldMap.anchors.count)
        worldMap.anchors.forEach { anchor in
            self.arSceneView.session.remove(anchor: anchor)
        }
    }
    
    
    func addNode(_ node: ARNodeBuilder) {
        let anchor = ARAnchor(name: node.name ?? K.String.empty, transform: node.simdTransform)
        node.setAnchor(anchor)
        arSceneView.scene.rootNode.addChildNode(node)
        arSceneView.session.add(anchor: anchor)
        arSceneView.nodes.append(node)
    }
    
    func removeNode(_ node: ARNodeBuilder?) {
        guard let node else {return}
        if let anchor = node.anchor {
            arSceneView.session.remove(anchor: anchor)
        }
        node.removeFromParentNode()
    }
    
    
//  MARK: - PRIVATE Area
    private func dataToWorldMap(worldMapData: Data) throws -> ARWorldMap? {
        do {
            if let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: worldMapData) {
                return worldMap
            }
        } catch {
            throw Error.worldMap(typeError: .convertToWorldMap, error: "Invalid worldMap \(error.localizedDescription)")
        }
        return nil
    }

    private func setAlignment(_ alignment: Alignment, _ padding: CGFloat) {
        switch alignment {
            case .top:
                targetImage.view.frame.origin.y = self.view.bounds.minY + padding
            case .middle:
                targetImage.view.center.y = (self.view.bounds.midY) + padding
            case .bottom:
                targetImage.view.frame.origin.y = (self.view.bounds.maxY - targetImage.view.bounds.height) - padding
        }
    }
    
    private func createSceneView() {
        self.arSceneView = ARSceneView(frame: self.view.bounds)
    }
    
    private func configSceneView() {
        setEnabledTarget(true)
        setEnabledTargetDraggable(true)
    }
    
    private func addElements() {
        arSceneView.add(insideTo: self.view)
        targetImage.add(insideTo: self.view)
        targetBallImage.add(insideTo: targetImage.view)
    }
    
    private func configConstraints() {
        configArSceneViewConstraints()
        targetImage.applyConstraint()
        targetBallImage.applyConstraint()
    }
    
    private func configArSceneViewConstraints() {
        arSceneView.makeConstraints { make in
            make
                .setPin.equalToSuperView
                .apply()
        }
    }
    
    private func tryConvertDataToWorldMap(_ worldMapData: Data) -> ARWorldMap? {
        do {
            let worldMap = try dataToWorldMap(worldMapData: worldMapData)
            return worldMap
        } catch { }
        return nil
    }
    
    private func sendAnchorsOnWorldMap(_ worldMap: ARWorldMap?) {
        guard let worldMap else {return}
        let anchors = worldMap.anchors
        arSceneView.delegateARScene?.anchorsWorldMap(anchors)
    }
    
}
