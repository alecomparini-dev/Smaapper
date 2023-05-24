//
//  ButtonBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class ButtonBuilder: BaseAttributeBuilder {
    
    private var _config = UIButton.Configuration.plain()
    private var titleWeight: UIFont.Weight = .regular
    
    private var _button: Button
    var button: Button { self._button }
    var view: Button { self._button }
    
    init() {
        self._button = Button(frame: .zero)
        super.init(_button)
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
        _button.configuration = config
        self.setTitleColor(.white, .normal)
    }
    
    
    
    @discardableResult
    func setTitle(_ title: String, _ state: UIControl.State) -> Self {
        _button.setTitle(title, for: state)
        return self
    }

    @discardableResult
    func setTitleColor(_ color: UIColor, _ state: UIControl.State) -> Self {
        _button.setTitleColor(color, for: state)
        return self
    }
    

    @discardableResult
    func setTintColor(_ color: UIColor) -> Self {
        _button.tintColor = color
        return self
    }
    
    @discardableResult
    func setFont(_ font: UIFont?) -> Self {
        if let font {
            _button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
                var attr = attrTransformer
                attr.font = font
                return attr
            }
        }
        return self
    }
    
    @discardableResult
    func setTitleSize(_ ofSize: CGFloat) -> Self {
        _button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
            var attr = attrTransformer
            attr.font = .systemFont(ofSize: ofSize, weight: self.titleWeight)
            return attr
        }
        _button.titleLabel?.font = UIFont.systemFont(ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func setTitleWeight(_ weight: UIFont.Weight) -> Self {
        self.titleWeight = weight
        let fontSize = self._button.titleLabel?.font.pointSize
        _button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrTransformer in
            var attr = attrTransformer
            attr.font = UIFont.systemFont(ofSize: fontSize ?? 0, weight: weight)
            return attr
        }
        return self
    }
     
    @discardableResult
    func setTitleAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        _button.contentHorizontalAlignment = alignment
        return self
    }

    @discardableResult
    func setActivateDisabledButton(_ startDisable: Bool) -> Self {
        self._button.activateDisabledButton = true
        setTitleColor(_button.titleColor(for: .normal)!.withAlphaComponent(0.3), .disabled)
        if startDisable {
            _button.isEnabled = false
        }
        return self
    }

    @discardableResult
    func setFloatButton() -> Self {
        self._button.layer.zPosition = 10000
        return self
    }
    
    
    
    
    
    
    
    

    
    //  MARK: - Action Area
        @discardableResult
        func setTarget(_ target: Any, _ action: Selector , _ event: UIControl.Event) -> Self {
            self._button.addTarget(target, action: action, for: event )
            return self
        }
        
        

    
    
    
    
    
    
}
