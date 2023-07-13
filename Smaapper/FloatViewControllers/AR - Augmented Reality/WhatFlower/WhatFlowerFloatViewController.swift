//
//  WhatFlowerFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/07/23.
//

import UIKit

class WhatFlowerFloatViewController: FloatViewController {
    static let identifierApp = K.WhatFlower.identifierApp
    
    lazy var screen: WhatFlowerView = {
        let view = WhatFlowerView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEnabledDraggable(true)
        setFrameWindow(CGRect(x: K.WhatFlower.FloatView.x,
                              y: K.WhatFlower.FloatView.y,
                              width: K.WhatFlower.FloatView.width ,
                              height: K.WhatFlower.FloatView.height))
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

//  MARK: - EXTENSION WhatFlowerViewDelegate

extension WhatFlowerFloatViewController: WhatFlowerViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
}
