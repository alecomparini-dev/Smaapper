//
//  LabelBuilder.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 10/04/23.
//

import UIKit

class Label: UILabel {

    internal var constraintsFlow: StartOfConstraintsFlow?
    
    
//  MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(_ text: String) {
        super.init(frame: .zero)
        _ = self.setText(text)
        initialization()
    }
    
    convenience init(_ text: String, _ color: UIColor) {
        self.init(text)
        let _ = self.setColor(color)
    }
    
    convenience init(_ text: String, _ color: UIColor, _ aligment: NSTextAlignment) {
        self.init(text, color)
        let _ = self.setTextAlignment(aligment)
    }
    
    private func initialization() {
        _ = self.setColor(LabelDefault.color)
            .setFont(LabelDefault.font)
            .setTextAlignment(LabelDefault.aligment)
            .setNumberOfLines(LabelDefault.numberOfLines)
    }
    
    
//  MARK: - Properties
    
    func setText(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    func setColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
        
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    func setFont(_ font: UIFont?) -> Self {
        if let font {
            self.font = font
        }
        return self
    }

    func setTextAttributed(_ attributedText: NSMutableAttributedString) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    func setNumberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
}



//  MARK: - Extension BaseComponentProtocol
extension Label: BaseComponentProtocol {
    
    @discardableResult
    func setBorder(_ border: (BorderBuilder) -> BorderBuilder) -> Self {
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
    func setTapGesture(_ gesture: (TapGesture) -> TapGesture) -> Self {
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


