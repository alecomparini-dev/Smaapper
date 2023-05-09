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
        addElements()
        _ = setGradient { build in
            build
//                .setColor([UIColor.HEX("#17191a"), UIColor.HEX("#17191a"),  UIColor.HEX("#17191a")])
                .setColor([UIColor.HEX("#06312a"), UIColor.HEX("#06312a"),  UIColor.HEX("#06312a")])
//                .setColor([UIColor.HEX("#a71c1b"), UIColor.HEX("#a71c1b"),  UIColor.HEX("#a71c1b")])
//                .setColor([UIColor.HEX("#343641"), UIColor.HEX("#343641"),  UIColor.HEX("#343641")])
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
                    .setRadius(1)
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
//                    .setVerticalAlignmentY.setHorizontalAlignmentX.equalToSuperView
                    .setBottom.equalToSafeArea(-1)
                    .setHorizontalAlignmentX.equalToSafeArea
//                    .setTrailing.setLeading.equalToSafeArea(30)
                    .setHeight.equalToConstant(50)
                    .setWidth.equalToConstant(200)
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
//                    .setColor([UIColor.HEX("#ec9355"),UIColor.HEX("#ff6b00")]) // --> top demaisssssss
//                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")]) //--> Favorito de todos
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
//            .setShadow { build in
//                build
//                    .setColor(UIColor.HEX("#ed8f4b").withAlphaComponent(0.5))
//                    .setOffset(width: -2, height: -2)
//                    .setOpacity(1)
//                    .setRadius(20)
//                    .apply()
//            }
            .setShadow { build in
                build
                    .setColor(UIColor.HEX("#000000").withAlphaComponent(0.8))
                    .setOffset(width: 5, height: 5)
                    .setRadius(1)
                    .apply()
            }
            .setConstraints { build in
                build
//                    .setTop.equalTo(buttom1, .bottom, 20)
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
//                    .setVerticalAlignmentY.equalToSuperView
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
//                    .setColor([UIColor.HEX("#22272e"),UIColor.HEX("#2d343d")])
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
        if !buttomDownload.isEnabled {
            _ = floatButton.setShadow { build in
                build.setColor(UIColor.HEX("#ff710b"))
                    .setOffset(width: 0, height: 0)
                    .setOpacity(1)
                    .setRadius(4)
                    .setBringToFront()
                    .setID("light")
                    .apply()
            }
            dropdownMenu.show()
        }else {
            floatButton.removeShadowByID("light")
            dropdownMenu.hide()
        }
           
        buttom1.isEnabled = !buttom1.isEnabled
        buttomDownload.isEnabled = !buttomDownload.isEnabled
        
        
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
            .setPadding(5)
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
                    .setRadius(1)
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
//                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .setReferenceColor(UIColor.HEX("#06312a"))
//                    .setReferenceColor(UIColor.HEX("#a71c1b"))
//                    .setReferenceColor(UIColor.HEX("#343641"))
//                    .setLightShadeColor(.black.withAlphaComponent(0))
//                    .setDarkShadeColor(.black.withAlphaComponent(0))

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
        _ = menu.setOnTapDropdownMenu { section, row in
            print("sectionCaralho: \(section) - Linha Porra: \(row)")
        }
        
        menu.setLayoutSubMenu(createDropdownMenu())
        return menu
    }()
    
    private func createDropdownMenu() -> DropdownMenu {
        return DropdownMenu()
            .setBorder({ build in
                build
                    .setCornerRadius(18)
            })
            .setPaddingMenu(top: 15, left: 15, bottom: 10, right: 15)
            .setPaddingColuns(left: 5, right: 5)
            .setNeumorphism { build in
                build
//                    .setReferenceColor(UIColor.HEX("#17191a"))
                    .setReferenceColor(UIColor.HEX("#06312a"))
//                    .setReferenceColor(UIColor.HEX("#a71c1b"))
//                    .setReferenceColor(UIColor.HEX("#343641"))
                    .setShape(.concave)
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

        dropdownMenu.setDropdownMenuFromJson(getJson().data(using: .utf8)!)
        dropdownMenu.show()
                
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        print(location)
    }
    
    
    

}


//"leftImage": "rectangle.grid.2x2",

public func getJson() -> String{
    return """
[
    {
        "section": "Utilities",
        "rightImage": "util",
        "items": [
            {
                "title": "Alcool ou Gasolina",
                "leftImage": "fuelpump.fill"
            },
            {
                "title": "Todo-List",
                "leftImage": "list.bullet.clipboard.fill",
                "rightImage": "checklist"
            },
            {
                "title": "Timers",
                "leftImage": "timer.circle.fill"
            },
            {
                "title": "Racha Conta",
                "leftImage": "dollarsign.arrow.circlepath",
                "rightImage": "person.2.gobackward"
            },
            {
                "title": "Leitor de QRCode/CodBar",
                "leftImage": "qrcode.viewfinder"
            },
            {
                "title": "Lembretes",
                "leftImage": "note.text",
                "rightImage": "list.clipboard.fill"
            },
            {
                "title": "Playlist Youtube",
                "leftImage": "play.square.stack.fill",
                "rightImage": "play.rectangle.on.rectangle.fill"
            }
        ]
    },
    {
        "section": "Calculadoras",
        "rightImage": "calc",
        "items": [
            {
                "title": "Regra de 3",
                "leftImage": "3.square.fill"
            },
            {
                "title": "Mini Calculadora",
                "leftImage": "plusminus.circle.fill",
                "rightImage": "plus.rectangle.fill"
            },
            {
                "title": "Calculadora IMC",
                "leftImage": "scalemass.fill"
            },
            {
                "title": "Calculadora de Churras",
                "leftImage": "flame.fill"
            },
            {
                "title": "Conversor de Medidas",
                "leftImage": "arrow.left.and.right.righttriangle.left.righttriangle.right.fill"
            },
            {
                "title": "Calcula Gorjeta",
                "leftImage": "percent"
            }
        ]
    },
    {
        "section": "AR - Realidade Aumentada",
        "rightImage": "AR",
        "items": [
            {
                "title": "Fita Métrica",
                "leftImage": "ruler.fill"
            },
            {
                "title": "Dados",
                "leftImage": "dice.fill"
            },
            {
                "title": "Qual é a Flor",
                "leftImage": "leaf.fill"
            },
            {
                "title": "Qual é a Cor",
                "leftImage": "paintpalette.fill"
            },
            {
                "title": "Invisible Device",
                "leftImage": "wand.and.stars.inverse"
            }
        ]
    },
    {
        "section": "Jogos/Entretenimentos",
        "rightImage": "game",
        "items": [
            {
                "title": "Forca",
                "leftImage": "figure.mixed.cardio"
            },
            {
                "title": "Cara ou Coroa",
                "leftImage": "caracoroa"
            },
            {
                "title": "Jogo da Velha",
                "leftImage": "number.square.fill"
            },
            {
                "title": "Pedra/Papel/Tesoura",
                "leftImage": "scissors.badge.ellipsis"
            },
            {
                "title": "Dados",
                "leftImage": "dice.fill"
            }
        ]
    },
    {
        "section": "Informativos",
        "rightImage": "i",
        "items": [
            {
                "title": "Pergunte ao ChatGPT",
                "leftImage": "message.and.waveform.fill"
            },
            {
                "title": "Horóscopo do Dia",
                "leftImage": "bubbles.and.sparkles.fill",
                "rightImage": "sparkles"
            },
            {
                "title": "Clima Tempo",
                "leftImage": "cloud.sun.fill"
            },
            {
                "title": "Cotações",
                "leftImage": "dollarsign.circle"
            },
            {
                "title": "Próximos Feriados",
                "leftImage": "calendar.badge.exclamationmark"
            },
            {
                "title": "Recomendações de Filme",
                "leftImage": "film.stack.fill"
            }
        ]
    },
    {
        "section": "Auto Ajuda",
        "rightImage": "help",
        "items": [
            {
                "title": "Músicas e Citações 􀼺􀉞􀉛",
                "leftImage": "bookmark.square.fill",
                "rightImage": "book.fill"
            }
        ]
    }
]
"""

}


