//
//  TextFieldBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class TextFieldBuilder: BaseBuilder {
    
    private let nsNumberZero: NSNumber = 0.0
    
    enum NavigationTextField {
        case next
        case previous
    }
    
    private var textFieldConfigKeyboard: TextFieldConfigKeyboard?
    private let _textField: TextField
    
    var textField: TextField { self._textField }
    var view: TextField { self._textField }
    
    private var attributesPlaceholder: [NSAttributedString.Key: Any] = [:]
    private var toolbar: UIToolbar?
    
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
            .setPadding(7, .left)
            .setKeyboard { buid in
                buid
                    .setKeyboardAppearance(.light)
            }
    }
    
//  MARK: - GET Properties
    var getNumber: NSNumber {
        let numberFormatter = NumberFormatterBuilder().setMaximumFractionDigits(10).removeGroupingSeparator()
        return numberFormatter.getNumber(self.textField.text ?? K.String.zeroDouble) ?? nsNumberZero
    }
    
    func getNumber(_ buildFormatter: ((_ build: NumberFormatterBuilder) -> NumberFormatterBuilder)) -> NSNumber {
        let numberFormatter = buildFormatter(NumberFormatterBuilder())
        return numberFormatter.getNumber(self.textField.text ?? K.String.zeroDouble) ?? nsNumberZero
    }
    
    private func getDoubleValueOfTextField(_ text: String?) -> Double {
        if var textResult = text {
            if NumberFormatterBuilder.get.decimalSeparator != K.String.dot {
                textResult = textResult.replacingOccurrences(of: K.String.dot, with: K.String.empty)
            }
            return Double(textResult.replacingOccurrences(of: NumberFormatterBuilder.get.decimalSeparator, with: K.String.dot)) ?? .zero
        }
        return .zero
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
            string: _textField.placeholder ?? K.String.empty ,
            attributes: self.attributesPlaceholder)
        return self
    }
    
    @discardableResult
    func setPlaceHolderSize(_ size: CGFloat) -> Self {
        self.attributesPlaceholder.updateValue(UIFont.systemFont(ofSize: size), forKey: .font)
        _textField.attributedPlaceholder = NSAttributedString (
            string: _textField.placeholder ?? K.String.empty ,
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
    func setText(_ text: String) -> Self {
        _textField.text = text
        return self
    }
    
    @discardableResult
    func setTextNumber(_ number: String, _ buildFormatter: (_ build: NumberFormatterBuilder) -> NumberFormatterBuilder ) -> Self {
        let numberFormatter = buildFormatter(NumberFormatterBuilder())
        if let numberFormatted = numberFormatter.getString(number) {
            setText(numberFormatted)
        }
        setText(K.String.zeroDouble)
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
    func setPadding(_ padding: CGFloat, _ position: TextField.Position? = nil) -> Self {
        let paddingView = UIView(frame: CGRect(x: .zero, y: .zero, width: padding, height: .zero))
        setPadding(paddingView, position)
        return self
    }
    
    @discardableResult
    func setPadding(_ paddingView: UIView, _ position: TextField.Position? = nil) -> Self {
        if let position {
            addPaddingToTextField(paddingView, position)
            return self
        }
        addPaddingToTextField(paddingView, .left)
        addPaddingToTextField(paddingView, .right)
        return self
    }
    
    @discardableResult
    func setKeyboard(_ configKeyboard: (_ buid: TextFieldConfigKeyboard) -> TextFieldConfigKeyboard ) -> Self {
        self.textFieldConfigKeyboard = configKeyboard(TextFieldConfigKeyboard(self._textField))
        return self
    }
    
    @discardableResult
    func setFocus() -> Self {
        self.view.becomeFirstResponder()
        return self
    }
    
    
    
//  MARK: - DELEGATE TextField
    @discardableResult
    func setDelegate(_ delegate: TextFieldDelegate) -> Self {
        _textField.delegateTextField = delegate
        return self
    }
    
        
//  MARK: - PRIVATE Area
    
    private func addPaddingToTextField(_ paddingView: UIView, _ position: TextField.Position ) {
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
