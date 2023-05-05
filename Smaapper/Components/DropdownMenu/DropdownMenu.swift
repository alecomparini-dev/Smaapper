//
//  DropdownMenu.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/05/23.
//

import UIKit


class DropdownMenu: View {
    
    enum PositionMenu {
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    private var zPosition: CGFloat = 10001
    private var positionOpenMenu: DropdownMenu.PositionMenu = .rightBottom
    private var itemsHeight: CGFloat = 35
    private var menuHeight: CGFloat?
    private var menuWidth: CGFloat?
    private var openingPoint: CGPoint?
    
    private var sections: [DropdownMenuSection] = []
    private let dropdownJson: [String: Any]?
    
    init(_ dropdownJson: [String: Any]? = nil) {
        self.dropdownJson = dropdownJson
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        self.hide()
        self.layer.zPosition = zPosition
        
        let list = List()
            .setBackgroundColor(.clear)
            .setBorder { build in
                build.setColor(.red)
                    .setWidth(0)
                    .setCornerRadius(20)
            }
        
        list.add(insideTo: self)
        
        list.makeConstraints { build in
            build.setTop.setBottom.setLeading.setTrailing.equalToSuperView(10)
        }
        
    }
    
    
//  MARK: - Set Properties
    
    func setPositionOpenMenu(_ position: DropdownMenu.PositionMenu) -> Self {
        self.positionOpenMenu = position
        return self
    }
    
    func setItemsHeight(_ height: CGFloat) -> Self {
        self.itemsHeight = height
        return self
    }
    
    func setHeight(_ height: CGFloat) -> Self {
        self.menuHeight = height
        return self
    }
    
    func setWidth(_ width: CGFloat) -> Self {
        self.menuWidth = width
        return self
    }
    
    func setSections(_ menuSection: DropdownMenuSection) -> Self {
        self.sections.append(menuSection)
        return self
    }
    
    
//  MARK: - Show DropdownMenu
    func show(_ openingPoint: CGPoint) {
        self.openingPoint = openingPoint
        self.show()
    }
    
    func show() {
        
        
//        dropdownMenuFromJson()
        if self.dropdownJson != nil {
            dropdownMenuFromJson()
        }
        self.isHidden = false
        for constraint in self.constraints {
            if let menuHeight = self.menuHeight {
                if constraint.firstAttribute == .height {
                    constraint.constant = menuHeight
                }
            }
            if let menuWidth = self.menuWidth {
                if constraint.firstAttribute == .width {
                    constraint.constant = menuWidth
                }
            }
        }
        
    }

    func hide() {
        self.isHidden = true
    }
    
//  MARK: - Private Functions Area
    private func dropdownMenuFromJson() {
        let json = """
        [
            {
                "section": "PRIMEIRA SECTION",
                "rightImage": "heart",
                "items": [
                    {
                        "title": "Categorias",
                        "leftImage": "trash",
                        "subMenu": [
                            {
                                "section": "Utilidades",
                                "rightImage": "util",
                                "items": [
                                    {
                                        "title": "Alcool ou Gasolina",
                                        "leftImage": "forca"
                                    },
                                    {
                                        "title": "Todo-List",
                                        "leftImage": "caracoroa"
                                    },
                                    {
                                        "title": "Timers",
                                        "leftImage": "velha"
                                    },
                                    {
                                        "title": "Racha Conta",
                                        "leftImage": "mic"
                                    },
                                    {
                                        "title": "Leitor de QRCode/CodBar",
                                        "leftImage": "mic"
                                    },
                                    {
                                        "title": "Lembretes",
                                        "leftImage": "mic"
                                    },
                                    {
                                        "title": "Playlist Youtube",
                                        "leftImage": "mic"
                                    }
                                ]
                            },
                            {
                                "section": "Calculadoras",
                                "rightImage": "calc",
                                "items": [
                                    {
                                        "title": "Regra de 3",
                                        "leftImage": "3"
                                    },
                                    {
                                        "title": "Mini Calculadora",
                                        "leftImage": "calc"
                                    },
                                    {
                                        "title": "Calculadora IMC",
                                        "leftImage": "calc imc"
                                    },
                                    {
                                        "title": "Calculadora de Churras",
                                        "leftImage": "calc chu"
                                    },
                                    {
                                        "title": "Conversor de Medidas",
                                        "leftImage": "med"
                                    },
                                    {
                                        "title": "Calcula Gorjeta",
                                        "leftImage": "calc imc"
                                    }
                                ]
                            },
                            {
                                "section": "AR - Realidade Aumentada",
                                "rightImage": "AR",
                                "items": [
                                    {
                                        "title": "Fita Métrica",
                                        "leftImage": "forca"
                                    },
                                    {
                                        "title": "Dados",
                                        "leftImage": "caracoroa"
                                    },
                                    {
                                        "title": "Qual é a Flor",
                                        "leftImage": "velha"
                                    },
                                    {
                                        "title": "Qual é a Cor",
                                        "leftImage": "mic"
                                    },
                                    {
                                        "title": "Invisible Device",
                                        "leftImage": "mic"
                                    }
                                ]
                            },
                            {
                                "section": "Jogos/Entretenimentos",
                                "rightImage": "game",
                                "items": [
                                    {
                                        "title": "Forca",
                                        "leftImage": "forca"
                                    },
                                    {
                                        "title": "Cara ou Coroa",
                                        "leftImage": "caracoroa"
                                    },
                                    {
                                        "title": "Jogo da Velha",
                                        "leftImage": "velha"
                                    },
                                    {
                                        "title": "Pedra/Papel/Tesoura",
                                        "leftImage": "mic"
                                    },
                                    {
                                        "title": "Dados",
                                        "leftImage": "mic"
                                    }
                                ]
                            },
                            {
                                "section": "SUB MENUS + SUB MENUS TESTE",
                                "rightImage": "i",
                                "items": [
                                    {
                                        "title": "Pergunte ao ChatGPR",
                                        "leftImage": "forca"
                                    },
                                    {
                                        "title": "Horóscopo do Dia",
                                        "leftImage": "forca"
                                    },
                                    {
                                        "title": "Clima Tempo",
                                        "leftImage": "forca"
                                    },
                                    {
                                        "title": "Cotações",
                                        "leftImage": "forca",
                                        "subMenu": [
                                            {
                                                "section": "Europa",
                                                "rightImage": "help",
                                                "items": [
                                                    {
                                                        "title": "Euro",
                                                        "leftImage": "alcool"
                                                    },
                                                    {
                                                        "title": "Libras Esterlinas",
                                                        "leftImage": "libras"
                                                    },
                                                    {
                                                        "title": "Alemao",
                                                        "leftImage": "alemao"
                                                    }
                                                ]
                                            },
                                            {
                                                "section": "Asia",
                                                "rightImage": "asia",
                                                "items": [
                                                    {
                                                        "title": "Xiaome rs",
                                                        "leftImage": "gas"
                                                    },
                                                    {
                                                        "title": "Sei lá mais qual",
                                                        "leftImage": "gas"
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        "title": "Próximos Feriados",
                                        "leftImage": "forca"
                                    },
                                    {
                                        "title": "Recomendações de Filme",
                                        "leftImage": "forca"
                                    }
                                ]
                            },
                            {
                                "section": "Auto Ajuda",
                                "rightImage": "help",
                                "items": [
                                    {
                                        "title": "Músicas e Citações",
                                        "leftImage": "forca"
                                    }
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "section": "Recentes - SEGUNDA SECTION",
                "rightImage": "heart",
                "items": [
                    {
                        "title": "Regra de 3",
                        "leftImage": "mic",
                        "rightImage": "heart"
                    },
                    {
                        "title": "Alcool ou Gasolina",
                        "leftImage": "mic.fil",
                        "subMenu": [
                            {
                                "section": "Alcool",
                                "rightImage": "help",
                                "items": [
                                    {
                                        "title": "Falar Alcool",
                                        "leftImage": "alcool"
                                    }
                                ]
                            },
                            {
                                "section": "Gasolina",
                                "rightImage": "gas",
                                "items": [
                                    {
                                        "title": "Falar Gasolina",
                                        "leftImage": "gas"
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "title": "Fita Métrica",
                        "leftImage": "mic.fil",
                        "rightImage": "heart"
                    }
                ]
            },
            {
                "section": "Cofigurações - TERCEIRA SECTION",
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
""".data(using: .utf8)

        
        
//        if let dropdownJson = self.dropdownJson {
            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: dropdownJson, options: [])
                let result = try JSONDecoder().decode(Dropdown.self, from: json!)
                printaDireitoSaporra(result)
            } catch {
                print(error)
            }
//        }
    }
    
}






func printaDireitoSaporra(_ result: [DropdownMenuSection], _ tabPar: String = "", _ tabItem: String = "") {
    var tab = tabPar
    var itemTab = tabItem
    
    tab += "  "
    itemTab += "   "
    print("")
    result.forEach { menu in
        print("\(tab)#", menu.section ?? ""/*, "-" , menu.rightImage ?? ""*/)
        
        menu.items?.forEach({ item in
            print("\(itemTab)->", /*item.image ?? "", "-" ,*/ item.title ?? "")
            
            if item.subMenu?.count ?? 0 > 0 {
                printaDireitoSaporra(item.subMenu ?? [], tab, itemTab)
            }
            
        })
        
        print("")
    }
    
    
}


