//
//  TextField_.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class TextField: UITextField {
    
    enum Position {
         case left
         case right
     }
    
    static private var currentMainWindow: UIWindow?
    static private func hideKeyboardWhenViewTapped() {
        let mainWindow = CurrentWindow.get
        if (mainWindow == currentMainWindow) { return }
        mainWindow?.hideKeyboardWhenViewTapped()
        currentMainWindow = mainWindow
    }
    
    init() {
        super.init(frame: .zero)
        addHideKeyboardWhenTouchReturn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Resize.resize(self)
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
