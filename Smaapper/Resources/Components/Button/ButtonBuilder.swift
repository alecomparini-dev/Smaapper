//
//  ButtonBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class ButtonBuilder: BaseBuilder {
    
    private let hierarchyFloatButton: CGFloat = 10000
    
    private var _config = UIButton.Configuration.plain()
    private var titleWeight: UIFont.Weight = .regular
    private var actions: ButtonActions?
    
    private var button: Button
    var view: Button { self.button }
    
    
//  MARK: - Initializers
    
    init() {
        self.button = Button(frame: .zero)
        super.init(button)
        self.initialization()
    }
    
    convenience init(_ title: String) {
        self.init()
        self.setTitle(title, .normal)
    }
    
    internal var config: UIButton.Configuration {
        get { return self._config }
        set { self._config = newValue }
    }
    
    private func initialization() {
        button.configuration = config
        self.setTitleColor(.white, .normal)
    }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setTitle(_ title: String, _ state: UIControl.State) -> Self {
        button.setTitle(title, for: state)
        return self
    }

    @discardableResult
    func setTitleColor(_ color: UIColor, _ state: UIControl.State) -> Self {
        button.setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func setTintColor(_ color: UIColor) -> Self {
        button.tintColor = color
        return self
    }
    
    @discardableResult
    func setFont(_ font: UIFont?) -> Self {
        if let font {
            button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
                var attr = attrTransformer
                attr.font = font
                return attr
            }
        }
        return self
    }
    
    @discardableResult
    func setTitleSize(_ ofSize: CGFloat) -> Self {
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
            var attr = attrTransformer
            attr.font = .systemFont(ofSize: ofSize, weight: self.titleWeight)
            return attr
        }
        button.titleLabel?.font = UIFont.systemFont(ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func setTitleWeight(_ weight: UIFont.Weight) -> Self {
        self.titleWeight = weight
        let fontSize = self.button.titleLabel?.font.pointSize
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
            var attr = attrTransformer
            attr.font = UIFont.systemFont(ofSize: fontSize ?? 0, weight: weight)
            return attr
        }
        return self
    }
     
    @discardableResult
    func setTitleAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        button.contentHorizontalAlignment = alignment
        return self
    }

    @discardableResult
    func setActivateDisabledButton(_ startDisable: Bool) -> Self {
        self.button.activateDisabledButton = true
        setTitleColor(button.titleColor(for: .normal)!.withAlphaComponent(0.3), .disabled)
        if startDisable {
            button.isEnabled = false
        }
        return self
    }

    @discardableResult
    func setFloatButton() -> Self {
        self.button.layer.zPosition = hierarchyFloatButton
        bringToFront()
        return self
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setActions(_ action: (_ build: ButtonActions) -> ButtonActions) -> Self {
        if let actions = self.actions {
            self.actions = action(actions)
            return self
        }
        self.actions = action(ButtonActions(self))
        return self
    }
    
//  MARK: - Private Area
    private func bringToFront() {
        guard let superview = self.button.superview else {return}
        superview.bringSubviewToFront(self.button)
    }
    
}
