//
//  ImageView.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 22/04/23.
//

import UIKit

class ImageView: UIImageView {
    typealias tapActionClosureAlias = (_ imageView: UIImageView) -> Void
    
    private var size: CGFloat?
    private var weight: UIImage.SymbolWeight?
    
    private var tapAction: tapActionClosureAlias?
    private var constraintBuilder: StartOfConstraintsFlow?
    
    
//  MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(_ image: UIImage?) {
        self.init()
        if let image {
            let _ = setImage(image)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - Properties
    func setImage(_ image: UIImage?) -> Self {
        if let image {
            self.image = image
        }
        return self
    }
    
    func setContentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
    func setTintColor(_ color: UIColor) -> Self {
        self.image = image?.withRenderingMode(.alwaysTemplate)
        self.image?.withTintColor(color)
        tintColor = color
        return self
    }
    
    func setSize(_ size: CGFloat) -> Self {
        self.size = size
        setImageWithConfiguration()
        return self
    }
    
    func setWeight(_ weight: UIImage.SymbolWeight) -> Self {
        self.weight = weight
        setImageWithConfiguration()
        return self
    }
    
    
//  MARK: - ACTIONS
    func setOnTap(completion: @escaping tapActionClosureAlias ) -> Self {
        self.tapAction = completion
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ontapped))
        addGestureRecognizer(tap)
        return self
    }
    
    @objc private func ontapped() {
        tapAction?(self)
    }
    
    
    
//  MARK: - Constraints Area
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintBuilder = builderConstraint(StartOfConstraintsFlow(self))
        return self
    }
    
    func applyConstraint() {
        self.constraintBuilder?.applyConstraint()
    }
    
//  MARK: - Private Function Area
    
    private func setImageWithConfiguration() {
        if size == nil {
            self.size = image?.size.width
        }
        if let weight {
            self.image = image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size ?? 17, weight: weight ))
            return
        }
        self.image = image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: size ?? 17 ))
    }
    
}
