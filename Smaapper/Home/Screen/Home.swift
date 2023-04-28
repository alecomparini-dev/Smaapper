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
        let btn = Button("TESTE")
            .setHeight(50)
            .setWidth(280)
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
//                    .setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
                    .setBottom.equalToSafeArea(-1)
                    .setHorizontalAlignmentX.equalToSafeArea
//                    .setTrailing.setLeading.equalToSafeArea(30)
            }
            .setGradient { build in
                build
//                    .setColor([UIColor.HEX("#13547a"),UIColor.HEX("#50827c")]) // -> Aqua Splash
//                    .setColor([UIColor.HEX("#df667b"),UIColor.HEX("#df6e9d")]) // -> Passionate Bed
                    .setColor([UIColor.HEX("#09203f"),UIColor.HEX("#3e5a70")]) // -> Eternal Constance
                    .setColor([UIColor.HEX("#009245"),UIColor.HEX("#FCEE21")]) // -> Luscious Lime
                    .setColor([UIColor.HEX("#662D8C"),UIColor.HEX("#ED1E79")]) // -> Purple Lake **
                    .setColor([UIColor.HEX("#614385"),UIColor.HEX("#516395")]) // -> Kashmir *
                    .setColor([UIColor.HEX("#09203F"),UIColor.HEX("#537895")]) // -> Eternal Constance ***
                    .setColor([UIColor.HEX("#067D68"),UIColor.HEX("#50D5B7")]) // -> PENSAR
                    .setColor([UIColor.HEX("#2E3192"),UIColor.HEX("#1BFFFF")]) // -> Ocean Blue
                    .setColor([UIColor.HEX("#667eea"),UIColor.HEX("#764ba2")]) // -> Plum Plate *****
                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")]) //--> Favorito de todos
                    .setColor([UIColor.HEX("#FF512F"),UIColor.HEX("#DD2476")]) // -> Bloody Mary **
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
                    .setTrailing.setLeading.equalToSafeArea(10)
                    .setHeight.equalToConstant(60)
            }
            .setBackgroundColor(.yellow)
        return btn
    }()
    
    
    lazy var convertButton: Button = {
        let btn = Button("TESTE3")
            .setBorder { build in
                build.setCornerRadius(15)
                    .setColor(UIColor.HEX("#2d343d"))
                    .setWidth(1)
            }
            .setTitle("C", .normal)
            .setTitleColor(.white, .normal)
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#22272e"),UIColor.HEX("#2d343d")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setBackgroundColor(.red)
            .addTarget(self, #selector(didTapFloatingButton), .touchUpInside)
        return btn
    }()
    
    
    lazy var buttomTest3D: ElevationWrapper = {
        let btn = ElevationWrapper(convertButton)
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-650)
                    .setTrailing.equalToSafeArea(-20)
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(50)
            }
        return btn
    }()
    @objc func didTapFloatingButton() {
            // Ação do botão flutuante
            print("Floating button tapped!")
        }

    private func addElements() {
        buttomTest.add(insideTo: self)
        buttomTest.applyConstraint()
        

        floatButton.add(insideTo: self)
        floatButton.applyConstraints { build in
            build.setBottom.equalToSafeArea(-15)
                .setTrailing.equalToSafeArea(-10)
                .setHeight.setWidth.equalToConstant(50)
        }
        
        buttomTest2.add(insideTo: self)
        buttomTest2.applyConstraint()
        
        buttomTest3D.add(insideTo: self)
        buttomTest3D.applyConstraint()

        
        
        bringSubviewToFront(buttomTest2)
        bringSubviewToFront(floatButton)
        bringSubviewToFront(buttomTest)
        bringSubviewToFront(buttomTest3D)
        
        
    }
}
