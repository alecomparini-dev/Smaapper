//
//  TapeMeasureFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import UIKit

class TapeMeasureFloatViewController: FloatViewController {
    static let identifierApp = K.TapeMeasure.identifierApp
    
    lazy var screen: TapeMeasureView = {
        let view = TapeMeasureView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEnabledDraggable(true)
        setFrameWindow(CGRect(x: K.TapeMeasure.FloatView.positionX,
                              y: K.TapeMeasure.FloatView.positionY,
                              width: K.TapeMeasure.FloatView.width ,
                              height: K.TapeMeasure.FloatView.height))
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        UtilsFloatView.setShadowActiveFloatView(screen)
        screen.cameraARKitView.runSceneView()
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        UtilsFloatView.removeShadowActiveFloatView(screen)
        screen.cameraARKitView.pauseSceneView()
    }
    

//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
    }
    
}

//  MARK: - EXTENSION TapeMeasureViewDelegate

extension TapeMeasureFloatViewController: TapeMeasureViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
}
