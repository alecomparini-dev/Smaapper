//
//  ButtonImage.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 28/04/23.
//

import UIKit



class ButtonImage: Button {
    
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
    func setImageButton(_ image: UIImageView) -> Self {
        guard let image = image.image else {return self}
        super.configuration?.image = image
        super.setImage(image, for: .normal)
        return self
    }
    
    func setImagePlacement(_ alignment: NSDirectionalRectEdge ) -> Self {
        super.configuration?.imagePlacement = alignment
        return self
    }
    
    func setImageColor(_ color: UIColor) -> Self {
        super.configuration?.baseForegroundColor = color
        return self
    }
    
    func setImageSize( _ size: CGFloat? ) -> Self {
        guard let size else {return self}
        let img = ImageView(super.configuration?.image).setSize(size)
        _ = setImageButton(img)
        return self
    }
    
    func setImageWeight(_ weight: UIImage.SymbolWeight) -> Self {
        let img = ImageView(super.configuration?.image).setWeight(weight)
        _ = setImageButton(img)
        return self
    }


    func setImagePadding(_ padding: CGFloat) -> Self {
        super.configuration?.imagePadding = padding
        return self
    }
        
}
