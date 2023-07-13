//
//  WhatBeerFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/07/23.
//

import UIKit

class WhatBeerFloatViewController: FloatViewController {
    static let identifierApp = K.WhatBeer.identifierApp
    
    lazy var screen: WhatBeerView = {
        let view = WhatBeerView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEnabledDraggable(true)
        setFrameWindow(CGRect(x: K.WhatBeer.FloatView.x,
                              y: K.WhatBeer.FloatView.y,
                              width: K.WhatBeer.FloatView.width ,
                              height: K.WhatBeer.FloatView.height))
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

extension WhatBeerFloatViewController: WhatBeerViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
}
