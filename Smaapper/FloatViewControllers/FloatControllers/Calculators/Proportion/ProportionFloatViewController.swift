//
//  ProportionFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

class ProportionFloatViewController: FloatViewController {
    static let identifierApp = "proportion"
    
    lazy var screen: ProportionView = {
        let view = ProportionView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrameWindow(CGRect(x: 50, y: 150, width: 270, height: 190))
        setEnabledDraggable(true)
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        setShadow()
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        removeShadow()
    }
    
    
//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
    }
    
    private func setShadow() {
        UtilsFloatView.setShadowActiveFloatView(screen)
    }
    
    private func removeShadow() {
        UtilsFloatView.removeShadowActiveFloatView(screen)
    }
    
}


//  MARK: - EXTENSIONWeatherViewDelegate

extension ProportionFloatViewController: ProportionViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }

    
}

