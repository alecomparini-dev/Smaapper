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
        setTitleWindow(screen.createTitleView())
        setTitleHeight(35)
        configDraggable()
        configDelegate()
    }
    
    
    private func configDraggable() {
        self.setActions { build in
            build
                .setDraggable { build in
                    build
                        .setBeganDragging { draggable in
                            self.bringToFront
                        }
                }
                .setCloseWindow { floatWindow in
                    print("janela fechou")
                }
        }
        
        
    }
    
    private func configDelegate() {
        screen.delegate = self
    }
    
}

extension WeatherViewController: WeatherViewDelegate {
    func closeWindow() {
        self.dismiss()
    }
    
}
