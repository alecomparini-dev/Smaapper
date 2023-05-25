//
//  ImageView.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 22/04/23.
//

import UIKit

class ImageView: UIImageView {
    internal var constraintsFlow: StartOfConstraintsFlow?
    
    typealias tapActionClosureAlias = (_ imageView: UIImageView) -> Void
    private var tapAction: tapActionClosureAlias?
    
    
    //  MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(_ image: UIImage?) {
        self.init()
        if let image {
            _ = setImage(image)
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
        self.image = image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: size))
        return self
    }
    
    func setWeight(_ weight: UIImage.SymbolWeight) -> Self {
        self.image = image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(weight: weight))
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
    
    
}

//  MARK: - Extension BaseComponentProtocol
extension ImageView: BaseComponentProtocol {
    
    @discardableResult
    func setBorder(_ border: (_ build: BorderBuilder) -> BorderBuilder) -> Self {
        let _ = border(BorderBuilder(self))
        return self
    }
    
    @discardableResult
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> Self {
        _ = shadow(Shadow(self))
        return self
    }
    
    @discardableResult
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        _ = neumorphism(Neumorphism(self))
        return self
    }
    
    @discardableResult
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        _ = gradient(Gradient(self))
        return self
    }
    
    @discardableResult
    func setTapGesture(_ gesture: (_ build: TapGesture) -> TapGesture) -> Self {
        let _ = gesture(TapGesture(self))
        return self
    }
    
//  MARK: - Constraint Area
    @discardableResult
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintsFlow = builderConstraint(StartOfConstraintsFlow(self))
        return self
    }
    
    func applyConstraint() {
        self.constraintsFlow?.apply()
    }
    
}

