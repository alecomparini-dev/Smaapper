//
//  ButtonImageBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 28/04/23.
//

import UIKit



class ButtonImageBuilder: ButtonBuilder {
    
    
//  MARK: - Initializers

    init(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil) {
        super.init()
        self.initialization(image, state, size)
    }
    
    convenience init(_ image: UIImageView, _ state: UIControl.State) {
        self.init(image, state, nil)
    }
    
    convenience init(_ image: UIImageView, _ title: String) {
        self.init(image, .normal, nil)
        setTitle(title, .normal)
    }

    convenience init(_ image: UIImageView) {
        self.init(image, .normal, nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil) {
        setImageButton(image)
            .setImageSize(size)
            .setImagePadding(0)
    }
    
    
//  MARK: - Properties
    @discardableResult
    func setImageButton(_ image: UIImageView, _ state: UIControl.State = .normal) -> Self {
        guard let image = image.image else {return self}
        if state == .normal {
            super.view.configuration?.image = image
        }
        super.view.setImage(image, for: state)
        super.view.imageView?.contentMode = .scaleAspectFill
        return self
    }
    
    @discardableResult
    func setImagePlacement(_ alignment: NSDirectionalRectEdge ) -> Self {
        super.view.configuration?.imagePlacement = alignment
        return self
    }
        
    @discardableResult
    func setImageColor(_ color: UIColor) -> Self {
        super.view.configuration?.baseForegroundColor = color
        return self
    }
    
    @discardableResult
    func setImageSize( _ size: CGFloat? ) -> Self {
        guard let size else {return self}
        let img = ImageViewBuilder(super.view.configuration?.image).setSize(size).view
        setImageButton(img)
        return self
    }
    
    @discardableResult
    func setImageWeight(_ weight: UIImage.SymbolWeight) -> Self {
        let img = ImageViewBuilder(super.view.configuration?.image).setWeight(weight).view
        setImageButton(img)
        return self
    }

    @discardableResult
    func setImagePadding(_ padding: CGFloat) -> Self {
        super.view.configuration?.imagePadding = padding
        return self
    }
        
}
