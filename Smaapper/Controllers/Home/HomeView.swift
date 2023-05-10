//
//  Home.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class HomeView: UIView {
    
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
    
    @objc func didTapFloatingButton() {
        if dropdownMenu.isHidden {
            dropdownMenu.show()
        }else {
            floatButton.removeShadowByID("light")
            dropdownMenu.hide()
        }
    }
    
    
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
        let menu = DropdownMenu()
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
        .setConstraints { build in
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
    

    

}


//"leftImage": "rectangle.grid.2x2",

public func getJson() -> String{
    return """
[
    {
        "section": "Apps",
        "items": [
            {
                "title": "Notificações",
                "leftImage": "rectangle.grid.2x2.fill",
                "subMenu": [
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
                                "leftImage": "cedisign.circle.fill"
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
                                "leftImage": "die.face.6.fill"
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
            }
        ]
    },
    {
        "section": "Recentes",
        "rightImage": "heart",
        "items": [
            {
                "title": "Celular",
                "leftImage": "3.square.fill"
            },
            {
                "title": "Som e Tato",
                "leftImage": "fuelpump.fill"
            },
            {
                "title": "Central de Controle",
                "leftImage": "ruler.fill"
            }
        ]
    },
    {
        "section": "Configurações",
        "rightImage": "heart",
        "items": [
            {
                "title": "Perfil",
                "leftImage": "mic"
            },
            {
                "title": "Notificações",
                "leftImage": "mic.fil"
            }
        ]
    }
]
"""

}


