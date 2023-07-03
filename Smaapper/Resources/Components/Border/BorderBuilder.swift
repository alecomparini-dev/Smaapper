//
//  Border.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 10/04/23.
//

import Foundation
import UIKit


class BorderBuilder {
    
    enum Corner {
        case leftTop
        case rightTop
        case leftBottom
        case rightBottom
        case top
        case bottom
        case left
        case right
        case diagonalUp
        case diagonalDown
    }

    private weak var component: UIView!
    
    
//  MARK: - Initializers
    init(_ component: UIView) {
        self.component = component
    }

//  MARK: - Set Properties
    
    @discardableResult
    func setWidth(_ width: CGFloat) -> Self {
        component.layer.borderWidth = width
        return self
    }
    
    @discardableResult
    func setColor(_ color: UIColor) -> Self {
        component.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    func setCornerRadius(_ radius: CGFloat) -> Self {
        self.removeBorderStyleOfTextField()
        if !component.hasShadow() {
            component.layer.masksToBounds = true
        }
        component.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func setWhichCornersWillBeRounded(_ cornes: [BorderBuilder.Corner]) -> Self {
        component?.layer.maskedCorners = selectCorners(cornes)
        return self
    }
    
    
//  MARK: - Component Private Functions
    
    private func selectCorners(_ cornes: [BorderBuilder.Corner]) -> CACornerMask {
        var selection: CACornerMask = []
        cornes.forEach { corner in
            switch corner {
            case .leftTop:
                selection.insert(CACornerMask.layerMinXMinYCorner)
            
            case .rightTop:
                selection.insert(CACornerMask.layerMaxXMinYCorner)
            
            case .leftBottom:
                selection.insert(CACornerMask.layerMinXMaxYCorner)
            
            case .rightBottom:
                selection.insert(CACornerMask.layerMaxXMaxYCorner)
            
            case .top:
                selection.insert(CACornerMask.layerMinXMinYCorner)
                selection.insert(CACornerMask.layerMaxXMinYCorner)
            
            case .bottom:
                selection.insert(CACornerMask.layerMinXMaxYCorner)
                selection.insert(CACornerMask.layerMaxXMaxYCorner)
            
            case .left:
                selection.insert(CACornerMask.layerMinXMinYCorner)
                selection.insert(CACornerMask.layerMinXMaxYCorner)
            
            case .right:
                selection.insert(CACornerMask.layerMaxXMinYCorner)
                selection.insert(CACornerMask.layerMaxXMaxYCorner)
            
            case .diagonalUp:
                selection.insert(CACornerMask.layerMinXMaxYCorner)
                selection.insert(CACornerMask.layerMaxXMinYCorner)
            
            case .diagonalDown:
                selection.insert(CACornerMask.layerMinXMinYCorner)
                selection.insert(CACornerMask.layerMaxXMaxYCorner)
            }
        }
        return selection
    }
    
    private func removeBorderStyleOfTextField() {
        guard let component else {return}
        if component.isKind(of: UITextField.self) {
            (component as! UITextField).borderStyle = UITextField.BorderStyle.none
        }
    }
    
}
