//
//  RuleOfThreeFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import Foundation


class RuleOfThreeFloatViewController: FloatViewController {
    static let identifierApp = "rule_of_3"
    
    lazy var screen: RuleOfThreeView = {
        let view = RuleOfThreeView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrameWindow(CGRect(x: 50, y: 150, width: 250, height: 150))
        setTitleHeight(35)
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

extension RuleOfThreeFloatViewController: RuleOfThreeViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }

    
}

