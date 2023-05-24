//
//  ButtonImageBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 28/04/23.
//

import UIKit



class ButtonImageBuilder: ButtonBuilder {
    
    private var imgWithConfiguration: ImageView?
    
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
        _ = setImageButton(image)
            .setImageSize(size)
            .setImagePadding(5)
    }
    
    
//  MARK: - Properties
    @discardableResult
    func setImageButton(_ image: UIImageView) -> Self {
        guard let image = image.image else {return self}
        super.button.configuration?.image = image
        super.button.setImage(image, for: .normal)
        return self
    }
    
    @discardableResult
    func setImagePlacement(_ alignment: NSDirectionalRectEdge ) -> Self {
        super.button.configuration?.imagePlacement = alignment
        return self
    }
    
    @discardableResult
    func setImageColor(_ color: UIColor) -> Self {
        super.button.configuration?.baseForegroundColor = color
        return self
    }
    
    @discardableResult
    func setImageSize( _ size: CGFloat? ) -> Self {
        guard let size else {return self}
        let img = ImageView(super.button.configuration?.image).setSize(size)
        _ = setImageButton(img)
        return self
    }
    
    @discardableResult
    func setImageWeight(_ weight: UIImage.SymbolWeight) -> Self {
        let img = ImageView(super.button.configuration?.image).setWeight(weight)
        _ = setImageButton(img)
        return self
    }

    @discardableResult
    func setImagePadding(_ padding: CGFloat) -> Self {
        super.button.configuration?.imagePadding = padding
        return self
    }
        
}
