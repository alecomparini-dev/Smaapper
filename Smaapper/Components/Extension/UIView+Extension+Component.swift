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
            let layer = CALayer()
            layer.frame = self.bounds
            layer.cornerRadius = self.layer.cornerRadius
            layer.backgroundColor = color.cgColor
            self.layer.insertSublayer(layer, at: UInt32((self.layer.sublayers?.count ?? 1) - 1) )
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
    
    
//  MARK: - Apply Constraints
    
    func applyConstraints(_ buildConstraintFlow: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) {
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
