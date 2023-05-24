//
//  Button.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 20/04/23.
//

import UIKit


class Button: UIButton {
    
    private var _activateDisabledButton: Bool = false
    
    override var isEnabled: Bool {
        didSet {
            disableButton(isEnabled)
        }
    }
    
//  MARK: - GET Properties
    var activateDisabledButton: Bool {
        get { self._activateDisabledButton }
        set { self._activateDisabledButton = newValue }
    }
    
    
//  MARK: - Private Function Area
    private func disableButton(_ isEnabled: Bool) {
        if (!self._activateDisabledButton) { return }
        if !isEnabled {
            self.alpha = 0.6
            return
        }
        self.alpha = 1
    }
    
    
}


