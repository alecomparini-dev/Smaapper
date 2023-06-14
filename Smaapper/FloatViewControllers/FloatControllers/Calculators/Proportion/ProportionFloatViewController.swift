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
        setFrameWindow(CGRect(x: 50, y: 150, width: 280, height: 180))
        setEnabledDraggable(true)
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        UtilsFloatView.setShadowActiveFloatView(screen)
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        UtilsFloatView.removeShadowActiveFloatView(screen)
    }
    
    
//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
        screen.setTextFieldDelegate(self)
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


//  MARK: - EXTENSION TextFieldDelegate
extension ProportionFloatViewController: TextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: TextField) {
        self.select
    }
    
}
