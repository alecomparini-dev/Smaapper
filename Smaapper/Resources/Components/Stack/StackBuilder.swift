//
//  StackBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit


class StackBuilder: BaseBuilder {
    
    private(set) var stack: Stack
    var view: Stack { self.stack }
    
    init() {
        self.stack = Stack()
        super.init(self.stack)
    }
    
    
//  MARK: - SET Properties
    @discardableResult
    func setDistribution(_ distribution: UIStackView.Distribution) -> Self {
        stack.distribution = distribution
        return self
    }

    @discardableResult
    func setAxis(_ axis: NSLayoutConstraint.Axis) -> Self {
        stack.axis = axis
        return self
    }

    @discardableResult
    func setAlignment(_ alignment: UIStackView.Alignment) -> Self {
        stack.alignment = alignment
        return self
    }
    
    @discardableResult
    func setSpacing(_ spacing: CGFloat) -> Self {
        stack.spacing = spacing
        return self
    }
    
}
