//
//  TextFieldImage.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 11/04/23.
//

import UIKit



class TextFieldImage: TextField {
    
    typealias buildTextFieldImageAlias = (_ build: TextFieldImage) -> TextFieldImage
    
    private var onTapAction: ((_ imageView: UIImageView) -> Void)?
    
    enum Constants {
        static let margin: Int = 10
        static let imageTag: Int = 1
    }
    
    private var paddingView = UIView(frame: .zero)
    private let imageView: UIImageView
    private let position: TextField.Position
    private let margin: Int
    
    
//  MARK: - Initializers
    
    init(image: UIImage, position: TextField.Position, margin: Int? = Constants.margin) {
        self.imageView = UIImageView(image: image)
        self.position = position
        self.margin = margin ?? Constants.margin
        super.init("")
        self.setImage( self.imageView, position, margin ?? Constants.margin)
    }
    
    convenience init(_ image: UIImage) {
        self.init(image: image, position: .left)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - Set Properties
    func setImageSize(_ size: CGFloat, _ weight: UIImage.SymbolWeight? = nil) -> Self {
        imageView.image = imageView.image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size , weight: weight ?? .regular))
        return self
    }
    
    
//  MARK: - Set Actions
    func setOnTapImage(completion: @escaping (_ imageView: UIImageView) -> Void) {
        self.onTapAction = completion
        self.imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ontapped))
        self.imageView.addGestureRecognizer(tap)
    }
    
    @objc
    private func ontapped() {
        self.onTapAction?(self.imageView)
    }
    
    
//  MARK: - Component private functions
    
    private func setImage(_ image: UIImageView, _ position: TextField.Position, _ margin: Int) {
        DispatchQueue.main.async { [weak self] in
            guard var paddingView = self?.paddingView else { return }
            guard let self else {return}
            paddingView = self.createPaddingView(image, margin)
            self.setFrameImage(image)
            self.addImageInsidePaddingView(image, paddingView)
            self.setImageAlignmentInPaddingView(image, paddingView, position)
            addPaddingToTextField(paddingView, position)
            let _ = setTintColor(self.textColor ?? .black)
        }
    }
    
    private func createPaddingView(_ image: UIImageView, _ margin: Int) -> UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: Int(image.image?.size.width ?? 0) + Constants.margin, height: Int(self.frame.height)))
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
