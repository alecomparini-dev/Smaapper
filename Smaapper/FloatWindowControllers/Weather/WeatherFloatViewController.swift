//
//  WeatherViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/05/23.
//

import UIKit


class WeatherFloatViewController: FloatViewController {
    static let identifierApp = "weather"
    
    private var titleView: UIView?
    
    lazy var screen: WeatherView = {
        let view = WeatherView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleWindow(screen.titleView.view)
        setTitleHeight(35)
        setEnabledDraggable(true)
        configDelegate()
    }
    
    override func viewActivated() {
        super.viewActivated()
        setShadow()
    }
    
    override func viewDesactivated() {
        super.viewDesactivated()
        removeShadow()
    }
    
    
//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
    }
    
    private func setShadow() {
        self.setShadow { build in
            build
                .setColor(Theme.shared.currentTheme.primary)
                .setOffset(width: 0, height: 0)
                .setOpacity(0.8)
                .setRadius(2)
                .setBringToFront()
                .setID("activeWindow")
                .apply()
        }
    }
    
    private func removeShadow() {
        self.view.removeShadowByID("activeWindow")
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
