//
//  ButtonImage.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 28/04/23.
//

import UIKit


class IconButton: ButtonImage {
    
    init(_ image: UIImageView) {
        super.init(image, .normal, nil)
        self.initializationIconButton()
    }

    convenience init(_ image: UIImageView, _ title: String) {
        self.init(image)
        _ = setTitle(title, .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializationIconButton() {
        _ = super.setImagePlacement(.top)
    }

    
//  MARK: - Set
    
    override func setImagePlacement(_ alignment: NSDirectionalRectEdge) -> Self {
        print("It is not possible to change the alignment of the image on the Icon Button")
        return self
    }
    
    override func setTitleAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        print("It is not possible to change the title alignment on the Icon Button, will ever center")
        return self
    }
    
    
    
    
}








