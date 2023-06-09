//
//  ImageViewBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit

class ImageViewBuilder: BaseBuilder {
    
    private var imageView: ImageView
    private(set) var actions: ImageViewActions?
    
    var view: ImageView { self.imageView }
    
    init() {
        self.imageView = ImageView()
        super.init(self.imageView)
        self.actions = ImageViewActions(self)
    }
    
    convenience init(_ image: UIImage?) {
        self.init()
        setImage(image)
    }
    
    
//  MARK: - SET Properties

    @discardableResult
    func setImage(_ image: UIImage?) -> Self {
        if let image {
            self.imageView.image = image
        }
        return self
    }
    
    @discardableResult
    func setContentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.imageView.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func setTintColor(_ color: UIColor) -> Self {
        self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysTemplate)
        self.imageView.image?.withTintColor(color)
        self.imageView.tintColor = color
        return self
    }
    
    @discardableResult
    func setSize(_ size: CGFloat) -> Self {
        self.imageView.image = self.imageView.image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        return self
    }
    
    @discardableResult
    func setWeight(_ weight: UIImage.SymbolWeight) -> Self {
        self.imageView.image = self.imageView.image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(weight: weight))
        return self
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setActions(_ action: (_ build: ImageViewActions) -> ImageViewActions) -> Self {
        if let actions = self.actions {
            self.actions = action(actions)
            return self
        }
        self.actions = action(ImageViewActions(self))
        return self
    }
    
}
