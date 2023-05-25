//
//  ImageViewBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit

class ImageViewBuilder: BaseBuilder {
    
    private var _imageView: ImageView
    var imageView: ImageView { self._imageView }
    var view: ImageView { self._imageView }
    
    var actions: ImageViewActions?
    
    init() {
        self._imageView = ImageView()
        super.init(self._imageView)
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
            self._imageView.image = image
        }
        return self
    }
    
    @discardableResult
    func setContentMode(_ contentMode: UIView.ContentMode) -> Self {
        self._imageView.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func setTintColor(_ color: UIColor) -> Self {
        self._imageView.image = self._imageView.image?.withRenderingMode(.alwaysTemplate)
        self._imageView.image?.withTintColor(color)
        self._imageView.tintColor = color
        return self
    }
    
    @discardableResult
    func setSize(_ size: CGFloat) -> Self {
        self._imageView.image = self._imageView.image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        return self
    }
    
    @discardableResult
    func setWeight(_ weight: UIImage.SymbolWeight) -> Self {
        self._imageView.image = self._imageView.image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(weight: weight))
        return self
    }
    
}
