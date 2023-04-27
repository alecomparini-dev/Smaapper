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
        backgroundColor = .white
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var buttomTest: Button = {
        let btn = Button("Test")

            .setBorder { build in
                build.setCornerRadius(12)
                    .setWidth(1)

            }
            .setShadow { build in
                build.setColor(.black)
                    .setOffset(width: 10, height: 10)
                    .setRadius(12)
            }
            .setConstraints { build in
                build.setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
                    .setTrailing.setLeading.equalToSafeArea(30)
                    .setHeight.equalToConstant(50)
            }
            .setGradient { build in
                build.setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")])
                    .setAxialGradient(.leftToRight)
                    .apply()
            }
        return btn
    }()
    

    
    
    private func addElements() {
        buttomTest.add(insideTo: self)
        buttomTest.applyConstraint()
    }
}
