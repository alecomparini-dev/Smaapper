//
//  Home.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class HomeViewTests: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        addBackgroundColor()
    }
    
    private func addBackgroundColor() {
        _ = setGradient { build in
            build
                .setColor([UIColor.HEX("#17191a"), UIColor.HEX("#17191a"),  UIColor.HEX("#17191a")])
                .setAxialGradient(.leftTopToRightBottom)
                .apply()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var buttom1: Button = {
        let btn = Button("BUTTON 1")
            .setActivateDisabledButton(false)
            .setShadow { build in
                build
                    .setColor(.black)
                    .setOffset(width: 5, height: 5)
                    .setBlur(1)
                    .apply()
            }
            .setBorder { build in
                build
                    .setCornerRadius(18)
                    .setColor(.white.withAlphaComponent(0.5))
                    .setWidth(0.5)
            }
            .setConstraints { build in
                build
                    .setBottom.equalToSafeArea(-1)
                    .setHorizontalAlignmentX.equalToSafeArea
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(200)
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#FF512F"),UIColor.HEX("#DD2476")]) // -> Bloody Mary VENCEDOR
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
        return btn
    }()
    
    
    lazy var buttomLaranja: Button = {
        let btn = Button("HEADSET")
            .setFont(UIFont.systemFont(ofSize: 21))
            .setTitleWeight(.black)
            .setTitleAlignment(.left)
            .setTitleColor(UIColor.HEX("#000000").withAlphaComponent(0.3) , .normal)
            .setActivateDisabledButton(false)
            .setBorder({ build in
                build.setCornerRadius(20)
                    .setColor(UIColor.HEX("#f57f16").withAlphaComponent(0.5))
                    .setWidth(2)
                
            })
            .setNeumorphism({ build in
                build
                    .setShape(.none)
                    .setLightShadeColor(UIColor.HEX("#f08b46").withAlphaComponent(0.8))
                    .setDarkShadeColor(UIColor.black)
                    .setIntensity(percent: 100)
                    .setDistance(percent: 0)
                    .setBlur(percent: 50)
                    .apply()
            })
            .setShadow { build in
                build
                    .setColor(UIColor.HEX("#000000").withAlphaComponent(0.8))
                    .setOffset(width: 5, height: 5)
                    .setBlur(1)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView
                    .setLeading.equalToSafeArea(40)
                    .setHeight.equalToConstant(100)
                    .setWidth.equalToConstant(170)
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#ec9355"),UIColor.HEX("#ff6b00")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }

        return btn
    }()
    
    //TODO: - FAZERRRRRR O WEIGHT DA IMAGEM !!!!!!!!!
    lazy var botaozim: ButtonImage = {
        let btn = ButtonImage(UIImageView(image: UIImage(systemName: "chevron.right")))
            .setImageSize(13)
            .setTitleWeight(.black)
            .setTitleColor(UIColor.HEX("#FFFFFF") , .normal)
            .setBorder({ build in
                build.setCornerRadius(22.5)
            })
            .setNeumorphism({ build in
                build.setReferenceColor(UIColor.HEX("#25282a"))
                    .setShape(.none)
                    .setIntensity(percent: 100)
                    .apply()
            })
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#ec9355"),UIColor.HEX("#ff6b00")])
                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(buttomLaranja)
                    .setLeading.equalTo(buttomLaranja, .trailing, 50)
                    .setHeight.setWidth.equalToConstant(45)
            }
        return btn
    }()
    
    lazy var buttom3D: ButtonImage = {
        let btn = ButtonImage(UIImageView(image: UIImage(systemName: "mic.fill")))
            .setBorder({ build in
                build.setCornerRadius(12)
            })
            .setNeumorphism({ build in
                build.setReferenceColor(UIColor.HEX("#222427"))
                    .setShape(.none)
                    .apply()
            })
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-101)
                    .setLeading.equalToSafeArea(20)
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(50)
            }
            .addTarget(self, #selector(didTapFloatingButton), .touchUpInside)
        return btn
    }()
    
    @objc func didTapFloatingButton() {
    }
    
    lazy var buttomNormal: Button = {
        let btn = Button()
            .setTitle("Normal", .normal)
            .setBorder({ build in
                build.setCornerRadius(12)
                    .setWidth(1)
            })
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-201)
                    .setLeading.equalToSafeArea(20)
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(250)
            }
            .setBackgroundColor(.red)
        return btn
    }()
    
    lazy var buttomDownload: ButtonImage = {
        let btn = ButtonImage(UIImageView(image: UIImage(systemName: "arrow.down.to.line")))
            .setTitle("Download", .normal)
            .setImageSize(50)
            .setImagePadding(5)
            .setActivateDisabledButton(false)
            .setBorder { build in
                build
                    .setCornerRadius(20)
                    .setColor(.white.withAlphaComponent(0.5))
                    .setWidth(0.5)
            }
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(10)
                    .setTrailing.equalToSafeArea(-10)
                    .setHeight.equalToConstant(45)
                    .setWidth.equalToConstant(180)
            }
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#ed56ff"),UIColor.HEX("#b023ff")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setShadow { build in
                build
                    .setColor(.black)
                    .setOffset(width: 5, height: 5)
                    .setBlur(1)
                    .apply()
            }

        return btn
    }()
    
    lazy var subMenu: DropdownMenu = {
        let menu = DropdownMenu()
            .setBorder({ build in
                build.setCornerRadius(40)
                    .setWidth(0)
                    .setColor(.cyan)
            })
            .setNeumorphism { build in
                build.setReferenceColor(UIColor.HEX("#17191a"))
                    .setIntensity(percent: 100)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .apply()
            }
            .setConstraints { build in
                build.setTop.equalToSafeArea(80)
                    .setLeading.equalToSafeArea(100)
                    .setWidth.equalToConstant(200)
                    .setHeight.equalToConstant(200)
            }
        return menu
    }()
    
    
    lazy var floatButton: ButtonImage = {
        let img = UIImageView(image: UIImage(systemName: "rectangle.3.group"))
        let btn = ButtonImage(img)
            .setBorder({ build in
                build.setCornerRadius(18)
                    .setWidth(0)
                    .setColor(.systemGray.withAlphaComponent(0.2))
                    .setColor(.white.withAlphaComponent(0.1))
            })
            .setNeumorphism { build in
                build
                    .setShape(.concave)
                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .apply()
            }
            .setConstraints { build in
                build.setBottom.equalToSafeArea(-10)
                    .setTrailing.equalToSafeArea(-20)
                    .setHeight.setWidth.equalToConstant(60)
            }
            .addTarget(self, #selector(didTapFloatingButton), .touchUpInside)
            .setFloatButton()
        return btn
    }()
    
    
    lazy var dropdownMenu: DropdownMenu = {
        let menu = createDropdownMenu()
        _ = menu.setConstraints { build in
            build
                .setBottom.equalTo(floatButton, .top, -15)
                .setTrailing.equalTo(floatButton, .trailing, -5)
                .setHeight.equalToConstant(300)
                .setWidth.equalToConstant(240)
        }
        _ = menu.setAction { section, row in
//            print("sectionCaralho: \(section) - Linha Porra: \(row)")
        }
        return menu
    }()
    
    private func createDropdownMenu() -> DropdownMenu {
        return DropdownMenu()
            .setBorder({ build in
                build
                    .setCornerRadius(18)
            })
            .setRowHeight(45)
            .setPaddingMenu(top: 15, left: 15, bottom: 10, right: 15)
            .setPaddingColuns(left: 5, right: 5)
            .setNeumorphism { build in
                build
                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .setShape(.flat)
                    .setLightPosition(.leftTop)
                    .setDistance(percent: 0)
                    .setBlur(percent: 10)
                    .apply()
            }
    }
    
    
    private func addElements() {
        
        floatButton.add(insideTo: self)
        floatButton.applyConstraint()

//
//        buttomDownload.add(insideTo: self)
//        buttomDownload.applyConstraint()
//
//        buttom3D.add(insideTo: self)
//        buttom3D.applyConstraint()
//
//        buttom1.add(insideTo: self)
//        buttom1.applyConstraint()
//
//        buttomNormal.add(insideTo: self)
//        buttomNormal.applyConstraint()
//
//        buttomLaranja.add(insideTo: self)
//        buttomLaranja.applyConstraint()
//
//        botaozim.add(insideTo: self)
//        botaozim.applyConstraint()
        
        
//        DROPDOW MENU
        dropdownMenu.add(insideTo: self)
        dropdownMenu.applyConstraint()

                
    }
    

    

}

