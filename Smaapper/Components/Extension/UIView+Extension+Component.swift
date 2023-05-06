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
        }
        element.addSubview(self)
    }
    
    public func setBackgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    func setBackgroundColorLayer(_ color: UIColor) -> Self {
        DispatchQueue.main.async {
            let layer = CAShapeLayer()
            layer.frame = self.bounds
            layer.cornerRadius = self.layer.cornerRadius
            layer.fillColor = color.cgColor
            layer.backgroundColor = color.cgColor
            let position = UInt32(self.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0)
            self.layer.insertSublayer(layer, at: position )
        }
        return self
    }
    
    func setUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    
//  MARK: - SET BORDER
    func setBorder(_ border: (_ build: Border) -> Border) -> Self {
        let _ = border(Border(self))
        return self
    }
    
    
//  MARK: - SET SHADOW
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow )  -> Self {
        let _ = shadow(Shadow(self))
        return self
    }
    
//  MARK: - SET NEUMORPHISM
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        let _ = neumorphism(Neumorphism(self))
        return self
    }
    
    
//  MARK: - SET GRADIENT
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        let _ = gradient(Gradient(self))
        return self
    }
    
    
//  MARK: - Apply Constraints
    
    func makeConstraints(_ buildConstraintFlow: (_ make: StartOfConstraintsFlow) -> StartOfConstraintsFlow) {
        let constraints = buildConstraintFlow(StartOfConstraintsFlow(self))
        constraints.applyConstraint()
    }
    
    
//  MARK: - hideKeyboardWhenViewTapped
    
    func hideKeyboardWhenViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    


    
    
}
