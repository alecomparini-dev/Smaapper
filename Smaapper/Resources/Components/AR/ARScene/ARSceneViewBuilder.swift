//
//  ARSceneViewBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit
import ARKit
import SceneKit


enum ARSceneState {
    case waitingWorldMapRecognition
    case excessiveMotion
    case done
    
}

protocol ARSceneViewBuilderDelegate: AnyObject {
    func positionTouch(_ position: CGPoint)
    func saveWorldMap(_ worldMap: Data?, _ error: Error?)
    func loadAnchorWorldMap(_ anchor: ARAnchor)
    func requestCameraElevation(isElevation: Bool)
    func stateARSceneview(_ state: ARSceneState)
}


class ARSceneViewBuilder: ViewBuilder {
    weak var delegate: ARSceneViewBuilderDelegate?
    
    enum Alignment {
        case top
        case middle
        case bottom
    }
    
    private var monitoringWorldMap = false
    
    private var arSceneView: ARSCNView?
    private var configuration: ARWorldTrackingConfiguration = ARWorldTrackingConfiguration()
    
    private var snapshotARSceneView: UIImageView = UIImageView()
    private var positionTarget: ( aligment: Alignment, padding: CGFloat)?
    private var options: ARSession.RunOptions = []
    
    private var anchorsLoadWorldMap: [ARAnchor] = []
    

    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
        setPreferredFramesPerSecond(15)
        start()
    }
    
    private func start() {
        snapshotARSceneView.removeFromSuperview()
        createSceneView()
        createConfiguration()
        addArSceneView()
        configArSceneViewConstraints()
        repositionTarget()
        configDelegate()
    }

    private func addArSceneView() {
        arSceneView?.add(insideTo: self.view)
    }
    
    private func createConfiguration() {
        configuration = ARWorldTrackingConfiguration()
        configuration.isCollaborationEnabled = true
        if configuration.planeDetection.isEmpty {
            configuration.planeDetection = [.vertical, .horizontal]
        }
    }
    
    private func configDelegate() {
        arSceneView?.delegate = self
        arSceneView?.session.delegate = self
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
    
    func getPositionOnPlaneByTouch(positionTouch: CGPoint, _ alignment: ARRaycastQuery.TargetAlignment) -> ARRaycastResult? {
        if let raycastQuery = arSceneView?.raycastQuery(from: positionTouch, allowing: .existingPlaneGeometry, alignment: alignment) {
            if let castResult = arSceneView?.session.raycast(raycastQuery).first {
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
        if let cameraTransform = arSceneView?.session.currentFrame?.camera.transform {
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -((centimetersAhead ?? 0.0) / 100.0)
            return matrix_multiply(cameraTransform, translation)
        }
        return nil
    }
    
    
//  MARK: - SET Properties

    @discardableResult
    func setPlaneDetection(_ planeDetection: ARWorldTrackingConfiguration.PlaneDetection) -> Self {
        self.configuration.planeDetection = planeDetection
        return self
    }

    @discardableResult
    func setDebug(_ debugOptions: ARSCNDebugOptions) -> Self {
        arSceneView?.debugOptions = debugOptions
        return self
    }
    
    @discardableResult
    func setEnabledTarget(_ enabled: Bool) -> Self {
        targetImage.setHidden(!enabled)
        return self
    }
    
    @discardableResult
    func setOptions(_ options: ARSession.RunOptions) -> Self {
        self.options.insert(options)
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
            self?.positionTarget = (alignment,padding)
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
    
    @discardableResult
    func setPreferredFramesPerSecond(_ framesPerSecond: Int) -> Self {
        self.arSceneView?.preferredFramesPerSecond = framesPerSecond
        return self
    }
    
    
//  MARK: - DELEGATE
    @discardableResult
    func setDelegateARSceneView(_ delegate: ARSCNViewDelegate) -> Self {
        arSceneView?.delegate = delegate
        return self
    }
    
    @discardableResult
    func setDelegateARSession(_ delegate: ARSessionDelegate) -> Self {
        arSceneView?.session.delegate = delegate
        return self
    }

    
//  MARK: - ACTIONS
    
    func runSceneView() {
        start()
        arSceneView?.session.run(self.configuration, options: self.options)
    }
    
    func runSceneView(loadWorldMapData worldMapData: Data) throws {
        if worldMapData.isEmpty {
            runSceneView()
            return
        }
        start()
        return try runSceneWithWorldMap(worldMapData)
    }
    
    func pauseSceneView()  {
        Task {
            await invokeSaveWorldMap()
            addSnapShotToPauseAR()
            await arSceneView?.session.pause()
            removeARSceneView()
        }
    }
    
    func addNode(_ node: ARNodeBuilder) {
        let anchor = ARAnchor(name: node.name ?? K.String.empty, transform: node.simdTransform)
        node.setAnchor(anchor)
        arSceneView?.session.add(anchor: anchor)
        arSceneView?.scene.rootNode.addChildNode(node)
        Task {
            await invokeSaveWorldMap()
        }
    }
    
    func forceSaveWorldMap() {
        Task { await invokeSaveWorldMap() }
    }
    
 
//  MARK: - INVOKE SAVE WORLD MAP
    
    private func runSceneWithWorldMap(_ worldMapData: Data) throws {
        do {
            if let worldMap = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: worldMapData) {
                if !worldMap.anchors.isEmpty {
                    self.configuration.initialWorldMap = worldMap
                }
                self.arSceneView?.session.run(self.configuration, options: [.resetTracking, .removeExistingAnchors])
            }
        } catch {
            throw Error.worldMap(typeError: .invalidWorldMap , error: "Invalid worldMap \(error.localizedDescription)" )
        }
    }
    
    private func invokeSaveWorldMap() async {
        return await withCheckedContinuation( { [weak self] (continuation: CheckedContinuation) in
            self?.getCurrentWorldMap() { [weak self] worldMap,error in
                guard let self else {return}
                if let error {
                    delegate?.saveWorldMap(nil, Error.worldMap(typeError: .getWordlMap, error: error.localizedDescription))
                    return
                }
                
                if let worldMap {
                    do {
                        let worldMapData = try convertWorldMapToData(worldMap)
                        self.delegate?.saveWorldMap(worldMapData, nil)
                    } catch let error {
                        delegate?.saveWorldMap(nil, Error.worldMap(typeError: .convertToData, error: error.localizedDescription))
                    }
                    return
                }
            }
            continuation.resume()
        })
    }
    
    
//  MARK: - PRIVATE Area

    private func getCurrentWorldMap() async throws -> ARWorldMap {
        do {
            if let worldMap = try await arSceneView?.session.currentWorldMap() {
                return worldMap
            }
            throw Error.worldMap(typeError: .worldMapEmptyOrNil, error: "WorldMap is nil")
        } catch let error {
            throw Error.worldMap(typeError: .getWordlMap, error: error.localizedDescription)
        }
    }
    
    private func convertWorldMapToData(_ worldMap: ARWorldMap) throws -> Data {
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: worldMap, requiringSecureCoding: true)
        } catch {
            throw Error.worldMap(typeError: .convertToData, error: error.localizedDescription)
        }
    }
    
    private func getCurrentWorldMap(completion: @escaping (_ worldMap: ARWorldMap?, _ error: Error? ) -> Void) {
        Task {
            do {
                let worldMap = try await getCurrentWorldMap()
                completion(worldMap, nil)
            } catch let error {
                completion(nil, error as? Error)
            }
        }
    }
    
    private func removeARSceneView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            arSceneView?.removeFromSuperview()
            arSceneView = nil
        }
    }
    
    private func addSnapShotToPauseAR() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            guard let snapshot = arSceneView?.snapshot() else { return }
            snapshotARSceneView = UIImageView(image: snapshot)
            snapshotARSceneView.frame = arSceneView?.bounds ?? self.view.bounds
            view.addSubview(snapshotARSceneView)
        }
    }
    
    private func repositionTarget() {
        targetImage.setHidden(true)
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            if let positionTarget {
                setAlignment(positionTarget.aligment, positionTarget.padding)
                targetImage.setHidden(false)
            }
        }
        sendARSceneViewToBack()
    }
    
    private func sendARSceneViewToBack() {
        view.bringSubviewToFront(targetImage.view)
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
        self.arSceneView = ARSCNView(frame: self.view.bounds)
    }
    
    private func configSceneView() {
        setEnabledTarget(true)
        setEnabledTargetDraggable(true)
    }
    
    private func addElements() {
        targetImage.add(insideTo: self.view)
        targetBallImage.add(insideTo: targetImage.view)
    }
    
    private func configConstraints() {
        targetImage.applyConstraint()
        targetBallImage.applyConstraint()
    }
    
    private func configArSceneViewConstraints() {
        arSceneView?.makeConstraints { make in
            make
                .setPin.equalToSuperView
                .apply()
        }
    }
    
    private func isCameraInVerticalPosition(_ camera: ARCamera) -> Bool {
        let pitch = camera.eulerAngles.x
        let degreesVerticalPosition = -25.0...10.0
        if degreesVerticalPosition.contains(Double(pitch).piToDegrees) {
            return true
        }
        return false
    }
        
}


//  MARK: - EXTENSION DELEGATE ARSessionDelegate

extension ARSceneViewBuilder: ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        
        switch camera.trackingState {
        case .notAvailable:
            break
        
        case .limited( let reason ):
            switch reason {
                case .excessiveMotion:
                    print("excessiveMotion")
                    delegate?.stateARSceneview(.excessiveMotion)
                    break
                
                case .insufficientFeatures:
                    print("insufficientFeatures")
                    if !isCameraInVerticalPosition(camera) {
                        delegate?.requestCameraElevation(isElevation: false)
                        return
                    }

                case .relocalizing:
                    print("relocalizing")
                    delegate?.stateARSceneview(.waitingWorldMapRecognition)
                    if !isCameraInVerticalPosition(camera) {
                        delegate?.requestCameraElevation(isElevation: false)
                        return
                    }
                default:
                    break
                }
            
        case .normal:
            delegate?.stateARSceneview(.done)
            break
        }
    }
        
    func sessionWasInterrupted(_ session: ARSession) {
        Task { await invokeSaveWorldMap() }
    }
}


//  MARK: - EXTENSION DELEGATE ARSCNViewDelegate

extension ARSceneViewBuilder: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            print("PLANO:")
            return
        }
        print(anchor.identifier)
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: self.arSceneView) {
            delegate?.positionTouch(touchLocation)
        }
    }
    
}
