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
        
        func toSemanticContentAttribute() -> UISemanticContentAttribute {
            switch self {
            case .leading:
                return .forceLeftToRight
            case .trailing:
                return .forceRightToLeft
            }
        }
    }
    
//  MARK: - Initializers
    
    init(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil) {
        super.init()
        self.initialization(image, state, size)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(_ image: UIImageView, _ state: UIControl.State) {
        self.init(image, state, nil)
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
        let img = ImageView(currentImage ?? UIImage())
            .setSize(size)
            .setContentMode(.scaleAspectFit)
        setImage(img.image, for: .normal)
        return self
    }
    
//  MARK: - Private Function Area
    
    private func setImage(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil, _ alignment: UISemanticContentAttribute = .forceLeftToRight ) {
        if let size = size {
            setImage(image.image!.withConfiguration(UIImage.SymbolConfiguration(pointSize: size)), for: state)
            return
        }
        setImage(image.image!, for: state)
    }
        
}
