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
//        setFrameWindow(CGRect(x: 110, y: 390, width: 160, height: 250))
        setTitleWindow(screen.createTitleView())
        .setTitleHeight(35)
        
    }
    
    
    
    
}
