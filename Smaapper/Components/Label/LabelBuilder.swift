//
//  LabelBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit

class LabelBuilder: BaseBuilder {
    
    private var _label: Label
    var label: Label { self._label }
    var view: Label { self._label }
    
    var actions: LabelAction?
    
    init() {
        self._label = Label()
        super.init(self._label)
        self.actions = LabelAction(self)
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
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setText(_ text: String) -> Self {
        _label.text = text
        return self
    }
    
    @discardableResult
    func setColor(_ textColor: UIColor) -> Self {
        _label.textColor = textColor
        return self
    }
    
    @discardableResult
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self {
        _label.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func setFont(_ font: UIFont?) -> Self {
        if let font {
            _label.font = font
        }
        return self
    }
    
    @discardableResult
    func setTextAttributed(_ attributedText: NSMutableAttributedString) -> Self {
        _label.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func setNumberOfLines(_ numberOfLines: Int) -> Self {
        _label.numberOfLines = numberOfLines
        return self
    }
    
}
