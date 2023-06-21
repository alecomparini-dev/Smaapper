//
//  LabelBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit

class LabelBuilder: BaseBuilder {
    
    private var label: Label
    var view: Label { self.label }
    
    private var actions: LabelActions?
    
    init() {
        self.label = Label()
        super.init(self.label)
    }
    
    convenience init(_ text: String) {
        self.init()
        self.setText(text)
    }
    
    convenience init(_ text: String, _ color: UIColor) {
        self.init(text)
        let _ = self.setColor(color)
    }
    
    convenience init(_ text: String, _ color: UIColor, _ aligment: NSTextAlignment) {
        self.init(text, color)
        let _ = self.setTextAlignment(aligment)
    }
    
//  MARK: - GET Properties
    var getText: String? { return label.text }
    
//  MARK: - SET Properties
    
    @discardableResult
    func setText(_ text: String) -> Self {
        label.text = text
        return self
    }
    
    @discardableResult
    func setColor(_ textColor: UIColor) -> Self {
        label.textColor = textColor
        return self
    }
    
    @discardableResult
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self {
        label.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func setFont(_ font: UIFont?) -> Self {
        if let font {
            label.font = font
        }
        return self
    }
    
    @discardableResult
    func setTextAttributed(_ attributedText: NSMutableAttributedString) -> Self {
        label.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func setNumberOfLines(_ numberOfLines: Int) -> Self {
        label.numberOfLines = numberOfLines
        return self
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setActions(_ action: (_ build: LabelActions) -> LabelActions) -> Self {
        if let actions = self.actions {
            self.actions = action(actions)
            return self
        }
        self.actions = action(LabelActions(self))
        return self
    }
    
    
}
