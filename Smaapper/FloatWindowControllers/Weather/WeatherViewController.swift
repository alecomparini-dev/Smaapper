//
//  WeatherViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/05/23.
//

import UIKit


class WeatherViewController: FloatWindowViewController {
    
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
        
    private func configDelegate() {
        screen.delegate = self
    }
    
}

extension WeatherViewController: WeatherViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.viewMinimized()
    }

    
}
