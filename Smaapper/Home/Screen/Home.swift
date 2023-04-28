//
//  Home.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class Home: UIView {
    
    var acendeu = true
    
    
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
    
    lazy var buttom1: Button = {
        let btn = Button("BUTTON 1")
            .setHeight(50)
            .setWidth(280)

            .setActivateDisabledButton(false)
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
//                    .setColor([UIColor.HEX("#09203f"),UIColor.HEX("#3e5a70")]) // -> Eternal Constance
//                    .setColor([UIColor.HEX("#009245"),UIColor.HEX("#FCEE21")]) // -> Luscious Lime
//                    .setColor([UIColor.HEX("#662D8C"),UIColor.HEX("#ED1E79")]) // -> Purple Lake **
//                    .setColor([UIColor.HEX("#ED1E79"),UIColor.HEX("#662D8C")]) // -> Purple Lake INVERTIDO** <-
//                    .setColor([UIColor.HEX("#614385"),UIColor.HEX("#516395")]) // -> Kashmir *
//                    .setColor([UIColor.HEX("#067D68"),UIColor.HEX("#50D5B7")]) // -> PENSAR
//                    .setColor([UIColor.HEX("#2E3192"),UIColor.HEX("#1BFFFF")]) // -> Ocean Blue
//                    .setColor([UIColor.HEX("#667eea"),UIColor.HEX("#764ba2")]) // -> Plum Plate *****
//                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")]) //--> Favorito de todos
                    .setColor([UIColor.HEX("#FF512F"),UIColor.HEX("#DD2476")]) // -> Bloody Mary VENCEDOR
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
        return btn
    }()
    
    
    lazy var convertButton: Button = {
        let btn = Button()
            .setBorder { build in
                build.setCornerRadius(15)
                    .setColor(UIColor.HEX("#2d343d"))
                    .setWidth(1)
            }
            .setTitle("2", .normal)
            .setTitleColor(.white, .normal)
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#22272e"),UIColor.HEX("#2d343d")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setShadow({ build in
                build.setColor(UIColor.HEX("#f8493c"))
                    .setOpacity(1)
                    .setRadius(2)
                    .setOffset(width: 0, height: 0)
            })
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
        print("Floating button tapped!")
        buttom1.isEnabled = !buttom1.isEnabled
        buttomIMAGE.isEnabled = !buttomIMAGE.isEnabled
        
        
        
        
        if acendeu {
            let test = buttomTest3D.component
            test.setShadow({ build in
                build.setColor(UIColor.HEX("#f8493c"))
                    .setOpacity(0)
                    .setRadius(0)
                    .setOffset(width: 0, height: 0)
            })
        } else {
            let test = buttomTest3D.component
            test.setShadow({ build in
                build.setColor(UIColor.HEX("#f8493c"))
                    .setOpacity(1)
                    .setRadius(2)
                    .setOffset(width: 0, height: 0)
            })
        }
        
        acendeu = !acendeu
        
    }
    
    
    lazy var buttomIMAGE: ButtonImage = {
        let btn = ButtonImage(UIImageView(image: UIImage(systemName: "arrow.down.to.line")))
            .setHeight(50)
            .setWidth(200)
            .setImageSize(50)
//            .setPadding(80)
            .setTitle("Button Image", .normal)
            .setActivateDisabledButton(false)
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
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")]) //--> Favorito de todos
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
//                    .setBottom.equalToSafeArea(-1)
                    .setHorizontalAlignmentX.equalToSafeArea
//                    .setTrailing.setLeading.equalToSafeArea(30)
            }
        return btn
    }()
    
    private func addElements() {
        buttom1.add(insideTo: self)
        buttom1.applyConstraint()
        
        buttomTest3D.add(insideTo: self)
        buttomTest3D.applyConstraint()
        
        buttomIMAGE.add(insideTo: self)
        buttomIMAGE.applyConstraint()
        
        bringSubviewToFront(buttom1)
        bringSubviewToFront(buttomTest3D)
        
        
    }
}
