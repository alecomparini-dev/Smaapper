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
        setFrameWindow(CGRect(x: K.TapeMeasure.FloatView.x,
                              y: K.TapeMeasure.FloatView.y,
                              width: K.TapeMeasure.FloatView.width ,
                              height: K.TapeMeasure.FloatView.height))
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
