//
//  Button.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 20/04/23.
//

import UIKit


class Button: UIButton {
    
    private var activateDisabledButton: Bool = false
    private var constraintBuilder: StartOfConstraintsFlow?
    
    override var isEnabled: Bool {
        didSet {
            disableButton(isEnabled)
        }
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    init(_ title: String) {
        super.init(frame: .zero)
        let _ = self.setTitle(title, .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - Properties
    func setTitle(_ title: String, _ state: UIControl.State) -> Self {
        super.setTitle(title, for: state)
        return self
    }
    
    func setTitleColor(_ color: UIColor, _ state: UIControl.State) -> Self {
        super.setTitleColor(color, for: state)
        return self
    }
    
    func setFont(_ font: UIFont?) -> Self {
        if let font {
            self.titleLabel?.font = font
        }
        return self
    }
    
    func setTitleAlignment(_ alignment: NSTextAlignment) -> Self {
        self.titleLabel?.textAlignment = alignment
        return self
    }
    
    public func setActivateDisabledButton(_ startDisable: Bool) -> Self {
        self.activateDisabledButton = true
        if startDisable {
            isEnabled = false
        }
        return self
    }
    
    
//  MARK: - Action Area
    
    func addTarget(_ target: Any, _ action: Selector , _ event: UIControl.Event) -> Self {
        self.addTarget(target, action: action, for: event )
        return self
    }
    
    
//  MARK: - Private Function Area
    
    private func disableButton(_ isEnabled: Bool) {
        if (!self.activateDisabledButton) { return }
        if !isEnabled {
            self.alpha = 0.5
            return
        }
        self.alpha = 1
    }
    
    
//  MARK: - Constraint Area
    
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintBuilder = builderConstraint(StartOfConstraintsFlow(self))
        return self
    }
    
    func applyConstraint() {
        self.constraintBuilder?.applyConstraint()
    }
    
    
}
