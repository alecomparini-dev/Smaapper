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
    private var constraintBuilder: StartOfConstraintsFlow?
    private let paddingConst: CGFloat = 5
    
    static private var currentMainWindow: UIWindow?
    
    static private func hideKeyboardWhenViewTapped() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
            if (mainWindow == currentMainWindow) { return }
            mainWindow.hideKeyboardWhenViewTapped()
            currentMainWindow = mainWindow
        }
    }
    
    enum Position {
         case left
         case right
     }
    
//  MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        let _ = self.setDefault()
        addHideKeyboardWhenTouchReturn()
    }
    
    init(_ placeHolder: String) {
        super.init(frame: .zero)
        let _ = self.setDefault()
            .setPlaceHolder(placeHolder)
        addHideKeyboardWhenTouchReturn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

//  MARK: - Properties Default
    
    func setDefault() -> Self {
        return self.setAutoCapitalization(TextFieldDefault.autoCapitalization)
            .setAutoCorrectionType(TextFieldDefault.autoCorrectionType)
            .setPlaceHolderColor(TextFieldDefault.placeHolderColor)
            .setKeyboardType(TextFieldDefault.keyboardType)
            .setAlignment(TextFieldDefault.alignment)
            .setPadding(TextFieldDefault.paddingLeft, .left)
    }
    
    
//  MARK: - Properties
    func setPlaceHolder(_ placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    func setAttributedPlaceHolder(_ attributes: NSMutableAttributedString) -> Self {
        self.attributedPlaceholder = attributes
        return self
    }

    func setPlaceHolderColor(_ placeHolderColor: UIColor) -> Self {
        self.attributedPlaceholder = NSAttributedString (
            string: self.placeholder ?? "" ,
            attributes: [ NSAttributedString.Key.foregroundColor : placeHolderColor ])
        return self
    }
   
    func setTextColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    func setKeyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }

    func setText(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    func setAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    func setIsSecureText(_ flag: Bool) -> Self {
        self.isSecureTextEntry = flag
        return self
    }
    
    func setAutoCapitalization(_ autoCapitalizationType: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = autoCapitalizationType
        return self
    }
    
    func setAutoCorrectionType(_ autoCorrectionType: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = autoCorrectionType
        return self
    }
    
    func setTintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }
    
    func setFont(_ font: UIFont?) -> Self {
        if let font { self.font = font }
        return self
    }
    
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

    
//  MARK: - Constraints Area
    
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintBuilder = builderConstraint(StartOfConstraintsFlow(self))
        return self
    }
    
    func applyConstraint() {
        self.constraintBuilder?.applyConstraint()
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
