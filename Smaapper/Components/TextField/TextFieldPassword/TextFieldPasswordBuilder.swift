//
//  TextFieldPassword.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 12/04/23.
//

import UIKit

class TextFieldPasswordBuilder: TextFieldImageBuilder {
    
    init() {
        super.init(image: ImageView(UIImage(systemName: "eye.slash")), position: .right, margin: 10)
        let _ = self.setIsSecureText(true)
            .setOnTapImage(completion: openCloseEyes(_:))
    }
    
    convenience init(_ placeHolder: String) {
        self.init()
        super.setPlaceHolder(placeHolder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - ACTIONS THIS COMPONENT
    private func openCloseEyes(_ imageView: UIImageView) {
        if self.textField.isSecureTextEntry {
            imageView.image = UIImage(systemName: "eye")
        } else {
            imageView.image = UIImage(systemName: "eye.slash")
        }
        let _ = self.setIsSecureText(!self.textField.isSecureTextEntry)
    }
    
}
