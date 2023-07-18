//
//  BMICalculatorFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit


class BMICalculatorFloatViewController: FloatViewController {
    static let identifierApp = "bmi_calculator"
    
    lazy var screen: BMICalculatorView = {
        let view = BMICalculatorView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrameWindow(CGRect(x: 120, y: 200, width: 170, height: 200))
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
        Utils.setShadowActiveFloatView(screen)
    }
    
    private func removeShadow() {
        Utils.removeShadowActiveFloatView(screen)
    }
    
}


//  MARK: - EXTENSIONWeatherViewDelegate

extension BMICalculatorFloatViewController: BMICalculatorViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }

    
}

