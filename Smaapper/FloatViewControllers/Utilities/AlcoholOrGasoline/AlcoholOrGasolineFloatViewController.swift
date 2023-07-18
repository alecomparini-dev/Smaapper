//
//  AlcoholOrGasolineFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/07/23.
//

import UIKit

class AlcoholOrGasolineFloatViewController: FloatViewController {
    static let identifierApp = K.Alcohol.identifierApp
    
    lazy var screen: AlcoholOrGasolineView = {
        let view = AlcoholOrGasolineView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrameWindow(CGRect(x: K.Proportion.FloatView.x,
                              y: K.Proportion.FloatView.y,
                              width: K.Proportion.FloatView.width,
                              height: K.Proportion.FloatView.height))
        setEnabledDraggable(true)
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        Utils.setShadowActiveFloatView(screen)
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        Utils.removeShadowActiveFloatView(screen)
    }
    
    
//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
    }
    
}


//  MARK: - EXTENSION AlcoholOrGasolineViewDelegate

extension AlcoholOrGasolineFloatViewController: AlcoholOrGasolineViewDelegate {

    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
        
}

