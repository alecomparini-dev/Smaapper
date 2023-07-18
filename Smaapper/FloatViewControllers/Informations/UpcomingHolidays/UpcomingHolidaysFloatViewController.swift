//
//  UpcomingHolidaysFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit


class UpcomingHolidaysFloatViewController: FloatViewController {
    static let identifierApp = "upcoming_holidays"
    
    lazy var screen: UpcomingHolidaysView = {
        let view = UpcomingHolidaysView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrameWindow(CGRect(x: 50, y: 200, width: 200, height: 300))
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


//  MARK: - EXTENSION WeatherViewDelegate

extension UpcomingHolidaysFloatViewController: UpcomingHolidaysViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
}
