//
//  TextFieldBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit


class TextFieldBuilder: BaseBuilder {
    
    
    private var _textField: TextField
    var textField: TextField { self._textField }
    var view: TextField { self._textField }
    
    private var attributesPlaceholder: [NSAttributedString.Key: Any] = [:]
    
    init() {
        self._textField = TextField()
        super.init(self._textField)
        self.initialization()
    }
    
    convenience init(_ placeHolder: String) {
        self.init()
        setPlaceHolder(placeHolder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        self.setAutoCapitalization(.none)
            .setAutoCorrectionType(.no)
            .setPlaceHolderColor(.systemGray2)
            .setKeyboardType(.default)
            .setPadding(7, .left)
    }
    
    
    //  MARK: - Properties
    @discardableResult
    func setPlaceHolder(_ placeholder: String) -> Self {
        _textField.attributedPlaceholder = NSAttributedString (
            string: placeholder,
            attributes: self.attributesPlaceholder)
        return self
    }
    
    @discardableResult
    func setPlaceHolderColor(_ placeHolderColor: UIColor) -> Self {
        self.attributesPlaceholder.updateValue(placeHolderColor, forKey: .foregroundColor)
        _textField.attributedPlaceholder = NSAttributedString (
            string: _textField.placeholder ?? "" ,
            attributes: self.attributesPlaceholder)
        return self
    }
    
    @discardableResult
    func setPlaceHolderSize(_ size: CGFloat) -> Self {
        self.attributesPlaceholder.updateValue(UIFont.systemFont(ofSize: size), forKey: .font)
        _textField.attributedPlaceholder = NSAttributedString (
            string: _textField.placeholder ?? "" ,
            attributes: self.attributesPlaceholder)
        return self
    }
    
    @discardableResult
    func setAttributedPlaceHolder(_ attributes: NSMutableAttributedString) -> Self {
        _textField.attributedPlaceholder = attributes
        return self
    }
    
    @discardableResult
    func setTextColor(_ textColor: UIColor) -> Self {
        _textField.textColor = textColor
        return self
    }
    
    @discardableResult
    func setKeyboardType(_ keyboardType: UIKeyboardType) -> Self {
        _textField.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    func setText(_ text: String) -> Self {
        _textField.text = text
        return self
    }
    
    @discardableResult
    func setAlignment(_ textAlignment: NSTextAlignment) -> Self {
        _textField.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func setIsSecureText(_ flag: Bool) -> Self {
        _textField.isSecureTextEntry = flag
        return self
    }
    
    @discardableResult
    func setAutoCapitalization(_ autoCapitalizationType: UITextAutocapitalizationType) -> Self {
        _textField.autocapitalizationType = autoCapitalizationType
        return self
    }
    
    @discardableResult
    func setAutoCorrectionType(_ autoCorrectionType: UITextAutocorrectionType) -> Self {
        _textField.autocorrectionType = autoCorrectionType
        return self
    }
    
    @discardableResult
    func setTintColor(_ tintColor: UIColor) -> Self {
        _textField.tintColor = tintColor
        return self
    }
    
    @discardableResult
    func setFont(_ font: UIFont?) -> Self {
        if let font { _textField.font = font }
        return self
    }
    
    @discardableResult
    func setPadding(_ padding: CGFloat, _ position: TextField.Position) -> Self {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        addPaddingToTextField(paddingView, position)
        return self
    }
    
    func addPaddingToTextField(_ paddingView: UIView, _ position: TextField.Position ) {
        switch position {
            case .left:
                _textField.leftView = paddingView
                _textField.leftViewMode = .always
            
            case .right:
                _textField.rightView = paddingView
                _textField.rightViewMode = .always
        }
        
    }


        

    
    
    
}