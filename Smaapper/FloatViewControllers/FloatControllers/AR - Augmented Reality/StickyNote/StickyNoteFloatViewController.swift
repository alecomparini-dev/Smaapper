//
//  StickyNoteFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 03/07/23.
//

import UIKit

class StickyNoteFloatViewController: FloatViewController {
    static let identifierApp = K.Sticky.identifierApp
    
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
        screen.cameraARKit.runSceneView()
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
    
    private func addStickyOnAR() {
        
        
        let position = screen.cameraARKit.getPositionByCam(centimetersAhead: 5)
        
        guard let position else {return}
        
        let stickyAR = screen.getStickyAR().convertToImage ?? UIImage()
        
        let material = ARMaterialBuilder()
            .setDiffuseTexture(stickyAR)
            .setDiffuseTexture(UIColor.red)
        
        //TODO RETIRAR O SETPLANE ETC .. E PASSAR PARA O INIT, DEIXAR SÓ O SETMATERIAL NO GEOMETRY!!!!!!!!!!!!!!!!!!!!!!!
        let geometryPlane = ARGeometryBuilder()
            .setPlane { build in
                build
                    .setSize(0.1, 0.1)
            }
            .setSphere({ build in
                build
                    .setRadius(0.005)
            })
            .setMaterial(material)
        
        let getWorldPosition = screen.cameraARKit.getPositionOnPlaneByTarget(.any)
        
        let node = ARNodeBuilder()
            .setGeometry(geometryPlane)
            .setPosition(position)
            .setAutoFollowCamera()
        
//        node.position = position
        
        screen.cameraARKit.addNode(node)
        
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
        addStickyOnAR()
    }
    
    
}


//  MARK: - EXTENSION TapeMeasureViewDelegate

extension StickyNoteFloatViewController: ARSceneViewDelegate {
    
    func positionTouch(_ position: CGPoint) {
        
    }
    
    
}

