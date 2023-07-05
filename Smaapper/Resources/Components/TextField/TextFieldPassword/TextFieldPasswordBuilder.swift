//
//  TextFieldPassword.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 12/04/23.
//

import UIKit

class TextFieldPasswordBuilder: TextFieldImageBuilder {
    
    
//  MARK: - Initializers

    init(paddingRightImage: CGFloat = C.TextFieldPassword.paddingRight) {
        super.init(image: ImageViewBuilder(UIImage(systemName: C.TextFieldPassword.Images.eyeSlash)).view, position: .right, margin: paddingRightImage)
        self.setIsSecureText(true)
            .setActions { build in
                build.setTouchImage { [weak self] component, tapGesture in
                    guard let self else {return}
                    openCloseEyes(component as? UIImageView ?? UIImageView())
                }
            }
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
            imageView.image = UIImage(systemName: C.TextFieldPassword.Images.eyeOpen)
        } else {
            imageView.image = UIImage(systemName: C.TextFieldPassword.Images.eyeSlash)
        }
        self.setIsSecureText(!self.textField.isSecureTextEntry)
    }
    
}
