//
//  UIView+Extension+Component.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 11/04/23.
//

import UIKit

extension UIView {
    
    func add(insideTo element: UIView) {
        if element.isKind(of: UIStackView.self) {
            let element = element as! UIStackView
            element.addArrangedSubview(self)
            return
        }
        element.addSubview(self)
    }
    
    @discardableResult
    public func setBackgroundColor(_ color: UIColor) -> Self {
        if countShadows() > 0 {
            setBackgroundColorLayer(color)
            return self
        }
        self.backgroundColor = color
        return self
    }
    
   
    @discardableResult
    func setUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    
//  MARK: - Apply Constraints
    
    @discardableResult
    func makeConstraints(_ buildConstraintFlow: (_ make: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        let constraints = buildConstraintFlow(StartOfConstraintsFlow(self))
        constraints.apply()
        return self
    }
    
    @discardableResult
    func makeBorder(_ border: (_ make: BorderBuilder) -> BorderBuilder) -> Self {
        _ = border(BorderBuilder(self))
        return self
    }
    
    @discardableResult
    func makeShadow(_ shadow: (_ make: Shadow) -> Shadow) -> Self {
        _ = shadow(Shadow(self))
        return self
    }
    
    @discardableResult
    func makeNeumorphism(_ neumorphism: (_ make: Neumorphism) -> Neumorphism) -> Self {
        _ = neumorphism(Neumorphism(self))
        return self
    }
    
    @discardableResult
    func makeGradient(_ gradient: (_ make: Gradient) -> Gradient) -> Self {
        _ = gradient(Gradient(self))
        return self
    }
    
    
    @discardableResult
    func makeBlur(_ blur: (_ make: Blur) -> Blur) -> Self {
        _ = blur(Blur(self))
        return self
    }
    
//  MARK: - hideKeyboardWhenViewTapped
    
    func hideKeyboardWhenViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    

    private func setBackgroundColorLayer(_ color: UIColor) {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.cornerRadius = self.layer.cornerRadius
        layer.maskedCorners = self.layer.maskedCorners
        layer.fillColor = color.cgColor
        layer.backgroundColor = color.cgColor
        let position = UInt32(countShadows())
        self.layer.insertSublayer(layer, at: position )
    }
    
    private func countShadows() -> Int {
        return self.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0
    }

    
}

