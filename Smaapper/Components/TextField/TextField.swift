//
//  TextField.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 11/04/23.
//

import UIKit

protocol ComponentsProtocol {
    func applyConstraint()
}

class TextField: UITextField {
    internal var constraintsFlow: StartOfConstraintsFlow?
    internal var shadow: Shadow?
    internal var neumorphism: Neumorphism?
    internal var gradient: Gradient?
    
    enum Position {
         case left
         case right
     }
    
    static private var currentMainWindow: UIWindow?
    static private func hideKeyboardWhenViewTapped() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
            if (mainWindow == currentMainWindow) { return }
            mainWindow.hideKeyboardWhenViewTapped()
            currentMainWindow = mainWindow
        }
    }
    
    private let paddingConst: CGFloat = 5
    private var attributesPlaceholder: [NSAttributedString.Key: Any] = [:]
    
    
//  MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        self.setDefault()
        addHideKeyboardWhenTouchReturn()
    }
    
    init(_ placeHolder: String) {
        super.init(frame: .zero)
        self.setDefault()
        setPlaceHolder(placeHolder)
        addHideKeyboardWhenTouchReturn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

//  MARK: - Properties Default
    private func setDefault() {
        self.setAutoCapitalization(TextFieldDefault.autoCapitalization)
            .setAutoCorrectionType(TextFieldDefault.autoCorrectionType)
            .setPlaceHolderColor(TextFieldDefault.placeHolderColor)
            .setKeyboardType(TextFieldDefault.keyboardType)
            .setAlignment(TextFieldDefault.alignment)
            .setPadding(TextFieldDefault.paddingLeft, .left)
    }
    
    
//  MARK: - Properties
    @discardableResult
    func setPlaceHolder(_ placeholder: String) -> Self {
        self.attributedPlaceholder = NSAttributedString (
            string: placeholder,
            attributes: self.attributesPlaceholder)
        return self
    }
    
    @discardableResult
    func setPlaceHolderColor(_ placeHolderColor: UIColor) -> Self {
        self.attributesPlaceholder.updateValue(placeHolderColor, forKey: .foregroundColor)
        self.attributedPlaceholder = NSAttributedString (
            string: self.placeholder ?? "" ,
            attributes: self.attributesPlaceholder)
        return self
    }
    
    @discardableResult
    func setPlaceHolderSize(_ size: CGFloat) -> Self {
        self.attributesPlaceholder.updateValue(UIFont.systemFont(ofSize: size), forKey: .font)
        self.attributedPlaceholder = NSAttributedString (
            string: self.placeholder ?? "" ,
            attributes: self.attributesPlaceholder)
        return self
    }

    @discardableResult
    func setAttributedPlaceHolder(_ attributes: NSMutableAttributedString) -> Self {
        self.attributedPlaceholder = attributes
        return self
    }
    
    @discardableResult
    func setTextColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    @discardableResult
    func setKeyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }

    @discardableResult
    func setText(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func setAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func setIsSecureText(_ flag: Bool) -> Self {
        self.isSecureTextEntry = flag
        return self
    }
    
    @discardableResult
    func setAutoCapitalization(_ autoCapitalizationType: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = autoCapitalizationType
        return self
    }
    
    @discardableResult
    func setAutoCorrectionType(_ autoCorrectionType: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = autoCorrectionType
        return self
    }
    
    @discardableResult
    func setTintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }
    
    @discardableResult
    func setFont(_ font: UIFont?) -> Self {
        if let font { self.font = font }
        return self
    }
    
    @discardableResult
    func setPadding(_ padding: CGFloat, _ position: TextField.Position) -> Self {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        addPaddingToTextField(paddingView, position)
        return self
    }
    
    internal func addPaddingToTextField(_ paddingView: UIView, _ position: TextField.Position ) {
        switch position {
        case .left:
            self.leftView = paddingView
            self.leftViewMode = .always
        case .right:
            self.rightView = paddingView
            self.rightViewMode = .always
        }
        
    }


    
//  MARK: - ACTIONS THIS COMPONENT
    private func addHideKeyboardWhenTouchReturn(){
        self.addTarget(self, action: #selector(textFieldDidEndOnExit), for: .editingDidEndOnExit)
        TextField.hideKeyboardWhenViewTapped()
    }
    
    @objc
    private func textFieldDidEndOnExit() {
        self.resignFirstResponder()
    }
    
    
}


//  MARK: - Extension BaseComponentProtocol
extension TextField: BaseComponentProtocol {
    
    @discardableResult
    func setBorder(_ border: (_ build: Border) -> Border) -> Self {
        let _ = border(Border(self))
        return self
    }
    
    @discardableResult
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> Self {
        self.shadow = shadow(Shadow(self))
        return self
    }
    func applyShadow() {
        self.shadow?.apply()
    }
    
    @discardableResult
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        self.neumorphism = neumorphism(Neumorphism(self))
        return self
    }
    func applyNeumorphism() {
        self.neumorphism?.apply()
    }
    
    @discardableResult
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        self.gradient = gradient(Gradient(self))
        return self
    }
    func applyGradient() {
        self.gradient?.apply()
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


