//
//  Gradient.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/04/23.
//

import UIKit

class Gradient: CAGradientLayer {
    
    enum Direction {
        case leftToRight
        case rightToLeft
        case topToBottom
        case bottomToTop
        case leftBottomToRightTop
        case leftTopToRightBottom
        case rightBottomToLeftTop
        case rightTopToLeftBottom
    }
    
    private var _isAxial = false
    
    override init() {
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - GET/SET Properties
    var isAxial: Bool {
        get { self._isAxial }
        set { self._isAxial = newValue }
    }

    
    
//  MARK: - Initializers
    
    private func initialization() {
        self.shouldRasterize = true
        self.rasterizationScale = UIScreen.main.scale
        self.backgroundColor = .none
    }
    
    
}

