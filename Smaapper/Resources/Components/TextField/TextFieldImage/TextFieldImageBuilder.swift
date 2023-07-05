//
//  TextFieldImageBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class TextFieldImageBuilder: TextFieldBuilder {
    
    typealias onTapImageClosureAlias = (_ imageView: UIImageView) -> Void
    
    
//  MARK: - Properties
    private(set) var paddingView = UIView(frame: .zero)
    private(set) var imageView: UIImageView
    private let imagePosition: TextField.Position
    private let margin: CGFloat
    
    
//  MARK: - ACTIONS Properties
    private var onTapAction: onTapImageClosureAlias?
    
    
//  MARK: - Initializers
    
    init(image: ImageView, position: TextField.Position, margin: CGFloat = 10) {
        self.imageView =  image
        self.imagePosition = position
        self.margin = margin
        super.init()
        self.setImage( self.imageView, position, margin)
    }
    
    convenience init(_ image: ImageView) {
        self.init(image: image, position: .left)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setImageSize(_ size: CGFloat, _ weight: UIImage.SymbolWeight? = nil) -> Self {
        imageView.image = imageView.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size , weight: weight ?? .regular))
        return self
    }
    
    @discardableResult
    func setHideImage(_ hide: Bool) -> Self {
        self.imageView.isHidden = hide
        return self
    }
    
    override func setPadding(_ padding: CGFloat, _ position: TextField.Position? = nil) -> Self {
        if isImagePositionMatch(position) {
            return self
        }
        let position: TextField.Position = calculatePaddingPosition(position)
        super.setPadding(padding, position)
        return self
    }
    
    @discardableResult
    func setImage(_ image: UIImageView, _ position: TextField.Position, _ margin: CGFloat) -> Self {
        paddingView = self.createPaddingView(image, margin)
        self.setFrameImage(image)
        self.addImageInsidePaddingView(image, paddingView)
        self.setImageAlignmentInPaddingView(image, paddingView, position)
        super.setPadding(paddingView, position)
        setTintColor(self.textField.textColor ?? .black)
        return self
    }

    
//  MARK: - Set Actions
    
    @discardableResult
    func setActions(_ action: (_ build: TextFieldImageActions) -> TextFieldImageActions) -> Self {
        if let actions = self.actions {
            super.actions = action(actions as! TextFieldImageActions)
            return self
        }
        super.actions = action(TextFieldImageActions(self))
        return self
    }
    
    
//  MARK: - Private Area
    private func calculatePaddingPosition(_ position: TextField.Position? = nil) -> TextField.Position {
        if position == nil {
            return oppositeImagePosition()
        }
        return position!
    }
    
    private func oppositeImagePosition() -> TextField.Position {
        switch self.imagePosition {
            case .left:
                return .right
            case .right:
                return .left
        }
    }
    
    private func isImagePositionMatch(_ position: TextField.Position? = nil) -> Bool {
        return imagePosition == position
    }
    
    private func createPaddingView(_ image: UIImageView, _ margin: CGFloat) -> UIView {
        return UIView(frame: CGRect(x: .zero,
                                    y: .zero,
                                    width: (image.image?.size.width ?? .zero) + self.margin,
                                    height: self.textField.frame.height))
    }
    
    private func setFrameImage(_ image: UIImageView) {
        image.frame = CGRect(x: .zero,
                             y: .zero,
                             width: image.image?.size.width ?? .zero,
                             height: image.image?.size.height ?? .zero)
    }
    
    private func addImageInsidePaddingView(_ image: UIImageView, _ paddingImgView: UIView) {
        paddingImgView.addSubview(image)
    }
    
    private func setImageAlignmentInPaddingView(_ image: UIImageView, _ paddingView: UIView, _ position: TextField.Position) {
        image.center.x = paddingView.center.x + ((position == .left) ? 1 : -2)
        image.center.y = paddingView.bounds.midY
    }
    
}
