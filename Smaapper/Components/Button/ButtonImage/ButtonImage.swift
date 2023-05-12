//
//  ButtonImage.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 28/04/23.
//

import UIKit



class ButtonImage: Button {
    
    enum Position {
        case leading
        case trailing
        case bottom
        
        func toSemanticContentAttribute() -> UISemanticContentAttribute {
            switch self {
            case .leading:
                return .forceLeftToRight
            case .trailing:
                return .forceRightToLeft
            case .bottom:
                return .unspecified
            }
        }
    }
    
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
        _ = setTitle(title, .normal)
    }

    convenience init(_ image: UIImageView) {
        self.init(image, .normal, nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil) {
        setImage(image, state, size)
        _ = setPadding(10)
        tintColor = titleColor(for: .normal)
    }
    
    
//  MARK: - Properties
    
    func setAlignment(_ alignment: ButtonImage.Position ) -> Self {
        semanticContentAttribute = alignment.toSemanticContentAttribute()
        return self
    }
    
    func setPadding(_ padding: CGFloat) -> Self {
        super.config.imagePadding = padding
        configuration = config
        return self
    }
    
    func setImageSize( _ size: CGFloat) -> Self {
        guard let imgWithConfiguration else {return self}
        let img = imgWithConfiguration.setSize(size)
            .setContentMode(.scaleAspectFit)
        setImage(img.image, for: .normal)
        return self
    }
    
    func setImageWeight(_ weight: UIImage.SymbolWeight) -> Self {
        guard let imgWithConfiguration else {return self}
        let img = imgWithConfiguration.setWeight(weight)
        setImage(img.image, for: .normal)
        return self
    }

    
//  MARK: - Private Function Area
    
    private func setImage(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil, _ alignment: UISemanticContentAttribute = .forceLeftToRight ) {
        guard let image = image.image else {return}
        self.imgWithConfiguration = ImageView(image)
        if let size = size {
            setImage(image.withConfiguration(UIImage.SymbolConfiguration(pointSize: size)), for: state)
            return
        }
        setImage(image, for: state)
    }
        
}
