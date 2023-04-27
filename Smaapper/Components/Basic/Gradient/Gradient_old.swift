//
//  Gradient.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 31/03/23.
//

import UIKit

class Gradient_Old {

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
    
    private var gradientVM = GradientViewModel()
    
    func setColor(_ color: [UIColor]) -> Self {
        gradientVM.color = color
        return self
    }
    
    func setDirection(_ direction: Gradient.Direction) -> Self {
        gradientVM.direction = direction
        return self
    }
    
    func setPoint(_ x: Double, _ y: Double) -> Self {
        gradientVM.point = CGPoint(x: x, y: y)
        return self
    }
    
    func setType(_ type: CAGradientLayerType) -> Self {
        gradientVM.type = type
        return self
    }
    
    func apply(_ elem: UIView) {
        if !isValidColor() { return }
        let colors = gradientVM.color
        if gradientVM.type == .axial {
            DispatchQueue.main.async() {
                self.applyGradientAxial(elem, colors)
            }
            return
        }
        
        DispatchQueue.main.async() {
            self.applyOtherTypesGradients(elem, colors)
        }
    }
    
    private func isValidColor() -> Bool {
        if gradientVM.color.count == 0 {
            debugPrint("No color set, gradient not executed")
            return false
        }
        return true
    }
    
    private func applyGradientAxial(_ elem: UIView, _ colors: [UIColor]) {
        configGradient(elem)
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.frame = elem.bounds
//        setGradientDirection(gradient)
        gradient.type = .axial
        elem.layer.insertSublayer(gradient, at: 0)
    }
    
    private func applyOtherTypesGradients(_ elem: UIView, _ colors: [UIColor]) {
        configGradient(elem)
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        
        gradient.frame = elem.bounds
//        setGradientDirection(gradient)
        gradient.startPoint = gradientVM.point
        let endY = 0 + elem.frame.size.width / elem.frame.size.height / 2
        gradient.endPoint = CGPoint(x: 0, y: endY)
        gradient.type = gradientVM.type
        elem.layer.insertSublayer(gradient, at: 0)
    }
    
    private func configGradient(_ elem: UIView) {
        elem.backgroundColor = .clear
        elem.layoutIfNeeded()
    }
    
    
    
}
