//
//  CategoriesView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 13/05/23.
//

import UIKit


class CategoriesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBackgroundColor()
        addElements()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var list: List = {
        let list = List(.grouped)
            .setBackgroundColor(.clear)
            .setConstraints { build in
                build.setPin.equalToSafeArea
            }
        return list
    }()
    
    lazy var titleLabel: Label = {
       var label = Label()
            .setText("Categories")
            .setFont(UIFont.systemFont(ofSize: 17, weight: .semibold))
            .setTextAlignment(.left)
        return label
    }()
    

//  MARK: - Private Functions Area
    
    private func addElements() {
        list.add(insideTo: self)
    }
    
    private func applyConstraints() {
        list.applyConstraint()
    }
    
    
    private func addBackgroundColor() {
        _ = self.setGradient { build in
            build
                .setColor([UIColor.HEX("#17191a").getBrightness(1.7),  UIColor.HEX("#17191a").getBrightness(0.7)])
                .setAxialGradient(.leftTopToRightBottom)
                .setAxialGradient(.topToBottom)
                .apply()
        }
    }
    
}
