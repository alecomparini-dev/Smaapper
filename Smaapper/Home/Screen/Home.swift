//
//  Home.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class Home: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var buttomTest: Button = {
        let btn = Button("Test")
            .setShadow { build in
                build
                    .setColor(.black)
                    .setOffset(width: 3, height: 5)
                    .setRadius(1)
            }
            .setBorder { build in
                build
                    .setCornerRadius(25)
                    .setColor(.white.withAlphaComponent(0.5))
                    .setWidth(0.5)
            }
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
                    .setTrailing.setLeading.equalToSafeArea(30)
                    .setHeight.equalToConstant(50)
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
        return btn
    }()
    

    private func addElements() {
        buttomTest.add(insideTo: self)
        buttomTest.applyConstraint()
        
    }
}
