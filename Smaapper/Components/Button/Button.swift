//
//  Button.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 20/04/23.
//

import UIKit


class Button: UIButton {
    
    private var _config = UIButton.Configuration.plain()
    private var activateDisabledButton: Bool = false
    private var constraintBuilder: StartOfConstraintsFlow?
    
    override var isEnabled: Bool {
        didSet {
            disableButton(isEnabled)
        }
    }
    
    internal var config: UIButton.Configuration {
        get { return self._config }
        set { self._config = newValue }
    }
    
//  MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        initialization()
    }
    
    convenience init(_ title: String) {
        self.init()
        let _ = self.setTitle(title, .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initialization() {
        _ = self.setTitleColor(ButtonDefault.color, .normal)
            .setFont(ButtonDefault.font)
    }
    
    
//  MARK: - Properties
    
    
    
    
    
    
    
    func setTitle(_ title: String, _ state: UIControl.State) -> Self {
        super.setTitle(title, for: state)
        configuration = config
        return self
    }
    
    func setTitleColor(_ color: UIColor, _ state: UIControl.State) -> Self {
        super.setTitleColor(color, for: state)
        if state == .normal {
            _ = setTintColor(titleColor(for: .normal)!.withAlphaComponent(0.8))
        }
        return self
    }
    
    func setTintColor(_ color: UIColor) -> Self {
        tintColor = color
        return self
    }
    
    func setTitleSize(_ ofSize: CGFloat) -> Self {
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
            var attr = attrTransformer
            attr.font = UIFont.systemFont(ofSize: ofSize)
            return attr
        }
        configuration = config
        return self
    }
    
    func setFont(_ font: UIFont?) -> Self {
        if let font {
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
                var attr = attrTransformer
                attr.font = font
                return attr
            }
            configuration = config
        }
        return self
    }
    
    func setTitleWeight(_ weight: UIFont.Weight) -> Self {
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
            var attr = attrTransformer
            attr.font = UIFont.systemFont(ofSize: self.titleLabel?.font.pointSize ?? 17, weight: weight)
            return attr
        }
        configuration = config
        return self
    }
     
    func setTitleAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }

    func setActivateDisabledButton(_ startDisable: Bool) -> Self {
        self.activateDisabledButton = true
        _ = setTitleColor(titleColor(for: .normal)!.withAlphaComponent(0.3), .disabled)
        if startDisable {
            isEnabled = false
        }
        return self
    }

    func setFloatButton() -> Self {
        self.layer.zPosition = 1000
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
            self.alpha = 0.6
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
