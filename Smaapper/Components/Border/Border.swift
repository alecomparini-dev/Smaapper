//
//  Border.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 10/04/23.
//

import Foundation
import UIKit


class Border {
    
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

    private var component: UIView
    
    
//  MARK: - Initializers
    init(_ component: UIView) {
        self.component = component
    }

    
//  MARK: - Properties Default
    
    func setDefault() -> Self {
        return self.setWidth(BorderDefault.width)
            .setColor(BorderDefault.color)
            .setCornerRadius(BorderDefault.radius)
    }
    
    
//  MARK: - Set Properties
    
    func setWidth(_ width: CGFloat) -> Self {
        component.layer.borderWidth = width
        return self
    }
    
    func setColor(_ color: UIColor) -> Self {
        component.layer.borderColor = color.cgColor
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
//        component.layer.masksToBounds = true
        component.clipsToBounds = true
        self.removeBorderStyleOfTextField()
        component.layer.cornerRadius = radius
        component.layer.masksToBounds = false
        //TODO: - OLHAR ESTE PROBLEMA DO MASK AFETANDO O DROPDOWN -
        return self
    }
    
    func setWhichCornersWillBeRounded(_ cornes: [Border.Corner]) -> Self {
        component.layer.maskedCorners = selectCorners(cornes)
        return self
    }
    
    
//  MARK: - Component Private Functions
    
    private func selectCorners(_ cornes: [Border.Corner]) -> CACornerMask {
        
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
        if component.isKind(of: UITextField.self) {
            (component as! UITextField).borderStyle = UITextField.BorderStyle.none
        }
    }
    
}
