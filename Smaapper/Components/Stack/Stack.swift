//
//  Stack.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 14/05/23.
//

import UIKit

class Stack: UIStackView {
    
    private var constraintsFlow: StartOfConstraintsFlow?
    
    
//  MARK: - SET Properties
    @discardableResult
    func setDistribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }

    @discardableResult
    func setAxis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }

    @discardableResult
    func setAlignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    @discardableResult
    func setSpacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
    
    
//  MARK: - Contraints Area
    @discardableResult
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintsFlow = builderConstraint(StartOfConstraintsFlow(self))
        return self
    }
    
    func applyConstraint() {
        self.constraintsFlow?.applyConstraint()
    }

    
}
