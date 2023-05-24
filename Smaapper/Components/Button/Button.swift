//
//  Button.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 20/04/23.
//

import UIKit


class Button: UIButton {
    internal var constraintsFlow: StartOfConstraintsFlow?
    
    private var _config = UIButton.Configuration.plain()
    private var activateDisabledButton: Bool = false
    
    
    override var isEnabled: Bool {
        didSet {
            disableButton(isEnabled)
        }
    }
    
    private var titleWeight: UIFont.Weight = .regular
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
        self.setTitle(title, .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        configuration = config
        self.setTitleColor(ButtonDefault.color, .normal)
            .setFont(ButtonDefault.font)
    }
    
    
//  MARK: - Properties
    
    @discardableResult
    func setTitle(_ title: String, _ state: UIControl.State) -> Self {
        super.setTitle(title, for: state)
        return self
    }

    @discardableResult
    func setTitleColor(_ color: UIColor, _ state: UIControl.State) -> Self {
        super.setTitleColor(color, for: state)
        return self
    }
    

    @discardableResult
    func setTintColor(_ color: UIColor) -> Self {
        tintColor = color
        return self
    }
    
    @discardableResult
    func setFont(_ font: UIFont?) -> Self {
        if let font {
            configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
                var attr = attrTransformer
                attr.font = font
                return attr
            }
        }
        return self
    }
    
    @discardableResult
    func setTitleSize(_ ofSize: CGFloat) -> Self {
        configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
            var attr = attrTransformer
            attr.font = .systemFont(ofSize: ofSize, weight: self.titleWeight)
            return attr
        }
        titleLabel?.font = UIFont.systemFont(ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func setTitleWeight(_ weight: UIFont.Weight) -> Self {
        self.titleWeight = weight
        let fontSize = self.titleLabel?.font.pointSize
        configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
            var attr = attrTransformer
            attr.font = UIFont.systemFont(ofSize: fontSize ?? 0, weight: weight)
            return attr
        }
        return self
    }
     
    @discardableResult
    func setTitleAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }

    @discardableResult
    func setActivateDisabledButton(_ startDisable: Bool) -> Self {
        self.activateDisabledButton = true
        setTitleColor(titleColor(for: .normal)!.withAlphaComponent(0.3), .disabled)
        if startDisable {
            isEnabled = false
        }
        return self
    }

    @discardableResult
    func setFloatButton() -> Self {
        self.layer.zPosition = 10000
        return self
    }



//  MARK: - Action Area
    @discardableResult
    func setTarget(_ target: Any, _ action: Selector , _ event: UIControl.Event) -> Self {
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
    
    
}

//  MARK: - Extension BaseComponentProtocol
extension Button: BaseComponentProtocol {

    @discardableResult
    func setBorder(_ border: (_ build: BorderBuilder) -> BorderBuilder) -> Self {
        let _ = border(BorderBuilder(self))
        return self
    }
    
    @discardableResult
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> Self {
        _ = shadow(Shadow(self))
        return self
    }
    
    @discardableResult
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        _ = neumorphism(Neumorphism(self))
        return self
    }
    
    @discardableResult
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        _ = gradient(Gradient(self))
        return self
    }
    
    @discardableResult
    func setTapGesture(_ gesture: (_ build: TapGesture) -> TapGesture) -> Self {
        let _ = gesture(TapGesture(self))
        return self
    }
    
//  MARK: - Constraint Area
    @discardableResult
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintsFlow = builderConstraint(StartOfConstraintsFlow(self))
        return self
    }
    
    func applyConstraint() {
        self.constraintsFlow?.applyConstraint()
    }
    
}


