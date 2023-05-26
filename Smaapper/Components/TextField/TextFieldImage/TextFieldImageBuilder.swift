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
    private var paddingView = UIView(frame: .zero)
    private let imageView: UIImageView
    private let imagePosition: TextField.Position
    private let margin: Int
    
    
//  MARK: - Actions Properties
    private var onTapAction: onTapImageClosureAlias?
    
    
//  MARK: - Initializers
    
    init(image: ImageView, position: TextField.Position, margin: Int = 10) {
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
    
    
//  MARK: - Set Properties
    
    @discardableResult
    func setImageSize(_ size: CGFloat, _ weight: UIImage.SymbolWeight? = nil) -> Self {
        imageView.image = imageView.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size , weight: weight ?? .regular))
        return self
    }
    
    override func setPadding(_ padding: CGFloat, _ position: TextField.Position) -> Self {
        if imagePosition == position {
            return self
        }
        super.setPadding(padding, position)
        return self
    }
    
    
//  MARK: - Set Actions
    
    @discardableResult
    func setOnTapImage(completion: @escaping onTapImageClosureAlias) -> Self {
        self.onTapAction = completion
        self.paddingView
            .makeTapGesture({ make in
                make
                    .setAction(touchEnded: { [weak self] tapGesture in
                        guard let self else {return}
                        self.onTapAction?(self.imageView)
                    })
            })
        return self
    }

    
//  MARK: - Private Area
    
    private func setImage(_ image: UIImageView, _ position: TextField.Position, _ margin: Int) {
        paddingView = self.createPaddingView(image, margin)
        self.setFrameImage(image)
        self.addImageInsidePaddingView(image, paddingView)
        self.setImageAlignmentInPaddingView(image, paddingView, position)
        addPaddingToTextField(paddingView, position)
        setTintColor(self.textField.textColor ?? .black)
    }
    
    private func createPaddingView(_ image: UIImageView, _ margin: Int) -> UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: Int(image.image?.size.width ?? 0) + self.margin, height: Int(self.textField.frame.height)))
    }
    
    private func setFrameImage(_ image: UIImageView) {
        image.frame = CGRect(x: 0, y: 0, width: Int(image.image?.size.width ?? 0) , height: Int(image.image?.size.height ?? 0))
    }
    
    private func addImageInsidePaddingView(_ image: UIImageView, _ paddingImgView: UIView) {
        paddingImgView.addSubview(image)
    }
    
    private func setImageAlignmentInPaddingView(_ image: UIImageView, _ paddingView: UIView, _ position: TextField.Position) {
        image.center.x = paddingView.center.x + ((position == .left) ? 1 : -2)
        image.center.y = paddingView.bounds.midY
    }
    
}
