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
    
    private var stickyNodes: [ARNodeBuilder] = []
    private var wordMap: Data?
    
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
        screen.cameraARKit.runSceneView(wordMap)
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
    
    private func convertViewStickyARToImage() -> UIImage {
        return screen.getStickyAR().convertToImage ?? UIImage()
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
    
    private func settingsForAddingStickyNote() {
        let stickyAR = convertViewStickyARToImage()
        let material = ARMaterialBuilder()
            .setDiffuseTexture(stickyAR)
        let geometryPlane = createARPlane()
            .setMaterial(material)
        guard let position = screen.cameraARKit.getPositionByCam(centimetersAhead: 8) else {return}
        let nodeSticky = createARNode(geometryPlane).setPosition(position)
        nodeSticky.setIdentifier(screen.noteTextField.getText)
        addNodeArSceneView(nodeSticky)
        enabledOrDisableRedoButton()
    }
    
    private func addNodeArSceneView(_ node: ARNodeBuilder) {
        screen.cameraARKit.addNode(node)
        self.stickyNodes.append(node)
    }
    
    private func settingsForStickyNoteRemoval() {
        if stickyNodes.isEmpty {return}
        removeStickNoteAR()
        enabledOrDisableRedoButton()
    }
    
    private func removeStickNoteAR() {
        let nodeSticky: ARNodeBuilder? = self.stickyNodes.popLast()
        screen.cameraARKit.removeNode(nodeSticky)
    }
    
    private func enabledOrDisableRedoButton() {
        if stickyNodes.isEmpty {
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
        settingsForAddingStickyNote()
    }
    
    func redoButtonTapped() {
        settingsForStickyNoteRemoval()
    }
    
}


//  MARK: - EXTENSION TapeMeasureViewDelegate

extension StickyNoteFloatViewController: ARSceneViewDelegate {
    
    func saveWorldMap(_ worldMap: Data?, _ error: Error?) {
        self.wordMap = worldMap
    }
    
    func positionTouch(_ position: CGPoint) {
        
    }

    func anchorsWorldMap(_ anchors: [ARAnchor]) {
        recreatedNodes(anchors)
    }
    
    
    private func recreatedNodes(_ anchors: [ARAnchor]) {
        anchors.forEach { anchor in
            print(anchor.name ?? "" )
        }
    }
}

