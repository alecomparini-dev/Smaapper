//
//  StickyNoteFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 03/07/23.
//

import UIKit
import ARKit


class StickyNoteFloatViewController: FloatViewController {
    static let identifierApp = K.Sticky.identifierApp
    
    private var worldMap: Data?
    
    lazy var screen: StickyNoteView = {
        let view = StickyNoteView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    private func initialization() {
        setEnabledDraggable(true)
        setFrameWindow(CGRect(x: K.Sticky.FloatView.x,
                              y: K.Sticky.FloatView.y,
                              width: K.Sticky.FloatView.width ,
                              height: K.Sticky.FloatView.height))
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        UtilsFloatView.setShadowActiveFloatView(screen)
            screen.cameraARKit.runSceneView(worldMap)
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        UtilsFloatView.removeShadowActiveFloatView(screen)
        screen.cameraARKit.pauseSceneView()
    }
    

//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
        screen.cameraARKit.setDelegate(self)
    }
    
    
    private func createARPlane() -> ARGeometryBuilder {
        return ARGeometryBuilder()
            .setPlane { build in
                build
                    .setSize(0.08, 0.08)
            }
    }
    
    private func createARNode(_ geometry: ARGeometryBuilder) -> ARNodeBuilder {
        return ARNodeBuilder()
            .setGeometry(geometry)
            .setAutoFollowCamera()
    }
    
    private func addStickyNote() {
        let stickyView = screen.getStickyNote()
        configStickyNoteToAR(stickyView)
        hideKeyboard()
    }
    
    private func hideKeyboard() {
        screen.noteTextField.setText(K.String.empty)
            .setKeyboard { buid in
                buid
                    .setHideKeyboard(true)
            }
    }
    
    private func configStickyNoteToAR(_ stickyNote: UIView, _ position: simd_float4x4? = nil) {
        let stickyNoteMaterial = createStickyNoteMaterial(stickyNote)
        let stickyNoteARNode = configObjectAR(stickyNoteMaterial, position)
        addNodeArSceneView(stickyNoteARNode)
        enabledOrDisableRedoButton()
    }
    
    private func createStickyNoteMaterial(_ stickyNote: UIView) -> UIImage {
        return stickyNote.convertToImage ?? UIImage()
    }
    
    private func configObjectAR(_ stickyNoteMaterial: UIImage, _ position: simd_float4x4? = nil) -> ARNodeBuilder {
        let material = ARMaterialBuilder()
            .setDiffuseTexture(stickyNoteMaterial)
        
        let geometryPlane = createARPlane()
            .setMaterial(material)
        
        if let position = getPosition(position) {
            let stickyNoteARNode = createARNode(geometryPlane).setPosition(position)
            stickyNoteARNode.setIdentifier(screen.noteTextField.getText)
            return stickyNoteARNode
        }
        
        return ARNodeBuilder()
    }
    
    private func getPosition(_ position: simd_float4x4?) -> simd_float4x4? {
        if let position { return position }
        return screen.cameraARKit.getPositionByCam(centimetersAhead: 8)
    }
    
    
    private func addNodeArSceneView(_ node: ARNodeBuilder) {
        screen.cameraARKit.addNode(node)
    }
    
    private func revemoStickNote() {
        if screen.cameraARKit.nodes.isEmpty {
            enabledOrDisableRedoButton()
            return
        }
        removeStickNoteAR()
        enabledOrDisableRedoButton()
    }
    
    private func removeStickNoteAR() {
        let nodeSticky: ARNodeBuilder? = screen.cameraARKit.nodes.popLast()
        screen.cameraARKit.removeNode(nodeSticky)
    }
    
    private func enabledOrDisableRedoButton() {
        if screen.cameraARKit.nodes.isEmpty {
            screen.redoButtonStickyAR.setHidden(true)
            return
        }
        screen.redoButtonStickyAR.setHidden(false)
    }
    
}


//  MARK: - EXTENSION TapeMeasureViewDelegate

extension StickyNoteFloatViewController: StickyNoteViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
    func addButtonTapped() {
        addStickyNote()
    }
    
    func redoButtonTapped() {
        revemoStickNote()
    }
    
}


//  MARK: - EXTENSION TapeMeasureViewDelegate

extension StickyNoteFloatViewController: ARSceneViewDelegate {
    
    func saveWorldMap(_ worldMap: Data?, _ error: Error?) {
        if error != nil {
            print("ERRO", error?.localizedDescription ?? "" )
            return
        }
        self.worldMap = worldMap
    }
    
    func positionTouch(_ position: CGPoint) {
        
    }

    func anchorsWorldMap(_ anchors: [ARAnchor]) {
        recreatingStickyNoteOnWorldMap(anchors)
    }
    
    
    private func recreatingStickyNoteOnWorldMap(_ anchors: [ARAnchor]) {
        anchors.enumerated().forEach { index,anchor in
            let stickyView = screen.recreateStickyNote(anchor.name ?? K.String.empty)
            configStickyNoteToAR(stickyView, anchor.transform)
        }
    }
}

