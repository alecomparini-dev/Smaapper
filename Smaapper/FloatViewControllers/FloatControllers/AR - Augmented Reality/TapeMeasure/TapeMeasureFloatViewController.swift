//
//  TapeMeasureFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import UIKit

class TapeMeasureFloatViewController: FloatViewController {
    static let identifierApp = "tape_measure"
    
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
        setFrameWindow(CGRect(x: 10, y: 50, width: (Utils.currentWindow?.screen.bounds.width ?? 300)-20 , height: 500))
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        UtilsFloatView.setShadowActiveFloatView(screen)
        screen.arKitView.runSceneView()
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        UtilsFloatView.removeShadowActiveFloatView(screen)
        screen.arKitView.pauseSceneView()
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
