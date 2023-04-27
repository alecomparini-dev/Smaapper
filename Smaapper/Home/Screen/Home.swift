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

            .setBorder { build in
                build.setCornerRadius(12)
                    .setWidth(1)

            }
            .setShadow { build in
                build
                    .setColor(.black)
                    .setOffset(width: 10, height: 10)
                    .setRadius(12)
            }

            .setConstraints { build in
                build.setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
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
    

    lazy var caralho: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("caralho", for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        
        
        btn.layer.shadowRadius = 20
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowOffset = CGSize(width: 10, height: 10)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.masksToBounds = false
        return btn
    }()
    
    
    
    
    private func addElements() {
        buttomTest.add(insideTo: self)
        buttomTest.applyConstraint()
        
        
        caralho.add(insideTo: self)
        caralho.applyConstraints { build in
            build.setTop.equalToSafeArea(30)
                .setLeading.setTrailing.equalToSafeArea(30)
                .setHeight.equalToConstant(100)
        }
        
        
        
    }
}
