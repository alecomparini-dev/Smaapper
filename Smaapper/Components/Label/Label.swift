//
//  LabelBuilder.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 10/04/23.
//

import UIKit

class Label: UILabel {

    private var constraintsFlow: StartOfConstraintsFlow?
    
    
//  MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ text: String) {
        super.init(frame: .zero)
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
    
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintsFlow = builderConstraint(StartOfConstraintsFlow(self))
        return self
    }
    
    func applyConstraint() {
        self.constraintsFlow?.applyConstraint()
    }

    
    
//  MARK: - COMMON FUNCTIONS
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow )  -> Self {
        let _ = shadow(Shadow(self))
        return self
    }

    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        let _ = gradient(Gradient(self))
        return self
    }
    
}




