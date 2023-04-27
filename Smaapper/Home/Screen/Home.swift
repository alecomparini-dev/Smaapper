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
        backgroundColor = UIColor.HEX("#1c1e20")
        _ = self.setGradient { build in
            build
                .setColor([UIColor.HEX("#1c1e20"), UIColor.HEX("#1c1e20"),  UIColor.HEX("#27292c")])
                .setAxialGradient(.leftTopToRightBottom)
                .apply()
        }
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var floatButton: UIButton = {
        let floatButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        floatButton.center = CGPoint(x: bounds.width - 50, y: bounds.height - 50)
        floatButton.backgroundColor = .blue
        floatButton.layer.cornerRadius = 30
        floatButton.layer.shadowOpacity = 0.5
        floatButton.layer.shadowRadius = 5
        floatButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        return floatButton
    }()
    
    
    lazy var buttomTest: Button = {
        let btn = Button()
            .setHeight(50)
            .setWidth(250)
            .setShadow { build in
                build
                    .setColor(.black)
                    .setOffset(width: 3, height: 5)
                    .setRadius(1)
            }
            .setBorder { build in
                build
                    .setCornerRadius(18)
                    .setColor(.white.withAlphaComponent(0.5))
                    .setWidth(0.5)
            }
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
//                    .setBottom.equalToSafeArea(-1)
                    .setHorizontalAlignmentX.equalToSafeArea
//                    .setTrailing.setLeading.equalToSafeArea(30)
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
        return btn
    }()
    
    lazy var buttomTest2: Button = {
        let btn = Button("TESTE3")

            .setBorder { build in
                build
                    .setCornerRadius(18)
                    .setColor(.white.withAlphaComponent(0.5))
                    .setWidth(0.5)
            }
            .setConstraints { build in
                build
//                    .setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
                    .setBottom.equalToSafeArea(-10)
                    .setTrailing.setLeading.equalToSafeArea(30)
                    .setHeight.equalToConstant(60)
            }
            .setBackgroundColor(.yellow)
        return btn
    }()
    
    
    lazy var buttomTest3: Button3D = {
        let btn = Button3D()
            .setBorder { build in
                build.setCornerRadius(15)
            }
        return btn
    }()
    

    private func addElements() {
        buttomTest.add(insideTo: self)
        buttomTest.applyConstraint()
        

//        floatButton.add(insideTo: self)
//        floatButton.applyConstraints { build in
//            build.setBottom.equalToSafeArea(-15)
//                .setTrailing.equalToSafeArea(-15)
//                .setHeight.setWidth.equalToConstant(50)
//        }
//        buttomTest2.add(insideTo: self)
//        buttomTest2.applyConstraint()
        
        buttomTest3.add(insideTo: self)
        buttomTest3.applyConstraints { build in
            build.setBottom.equalToSafeArea(-15)
                .setTrailing.equalToSafeArea(-20)
                .setHeight.equalToConstant(50)
                .setWidth.equalToConstant(50)
        }
        
        bringSubviewToFront(buttomTest)
        
    }
}
