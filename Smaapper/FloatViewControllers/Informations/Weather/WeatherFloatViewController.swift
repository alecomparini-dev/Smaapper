//
//  WeatherViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/05/23.
//

import UIKit


class WeatherFloatViewController: FloatViewController {
    static let identifierApp = "weather"
    
    lazy var screen: WeatherView = {
        let view = WeatherView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrameWindow(CGRect(x: 50, y: 100, width: 160, height: 250))
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

extension WeatherFloatViewController: WeatherViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }

    
}
