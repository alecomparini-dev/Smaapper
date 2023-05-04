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
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setMenuHeight(_ height: CGFloat) -> Self {
        self.menuHeight = height
        return self
    }
    
    func setMenuWidth(_ width: CGFloat) -> Self {
        self.menuWidth = width
        return self
    }
    
    func setSections(_ menuSection: DropdownMenuSection) -> Self {
        self.sections.append(menuSection)
        return self
    }
    
    func show(_ openingPoint: CGPoint) {
        self.openingPoint = openingPoint
        self.show()
    }
    
    func show() {
        if self.dropdownJson != nil {
            dropdownMenuFromJson()
        }
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

    private func dropdownMenuFromJson() {
        let json = """
        [
            {
                "section": "PRIMEIRA SECTION",
                "trailing": "heart",
                "items": [
                    {
                        "title": "Categorias",
                        "image": "trash",
                        "subMenu": [
                            {
                                "section": "Utilidades",
                                "trailing": "util",
                                "items": [
                                    {
                                        "title": "Alcool ou Gasolina",
                                        "image": "forca"
                                    },
                                    {
                                        "title": "Todo-List",
                                        "image": "caracoroa"
                                    },
                                    {
                                        "title": "Timers",
                                        "image": "velha"
                                    },
                                    {
                                        "title": "Racha Conta",
                                        "image": "mic"
                                    },
                                    {
                                        "title": "Leitor de QRCode/CodBar",
                                        "image": "mic"
                                    },
                                    {
                                        "title": "Lembretes",
                                        "image": "mic"
                                    },
                                    {
                                        "title": "Playlist Youtube",
                                        "image": "mic"
                                    }
                                ]
                            },
                            {
                                "section": "Calculadoras",
                                "trailing": "calc",
                                "items": [
                                    {
                                        "title": "Regra de 3",
                                        "image": "3"
                                    },
                                    {
                                        "title": "Mini Calculadora",
                                        "image": "calc"
                                    },
                                    {
                                        "title": "Calculadora IMC",
                                        "image": "calc imc"
                                    },
                                    {
                                        "title": "Calculadora de Churras",
                                        "image": "calc chu"
                                    },
                                    {
                                        "title": "Conversor de Medidas",
                                        "image": "med"
                                    },
                                    {
                                        "title": "Calcula Gorjeta",
                                        "image": "calc imc"
                                    }
                                ]
                            },
                            {
                                "section": "AR - Realidade Aumentada",
                                "trailing": "AR",
                                "items": [
                                    {
                                        "title": "Fita Métrica",
                                        "image": "forca"
                                    },
                                    {
                                        "title": "Dados",
                                        "image": "caracoroa"
                                    },
                                    {
                                        "title": "Qual é a Flor",
                                        "image": "velha"
                                    },
                                    {
                                        "title": "Qual é a Cor",
                                        "image": "mic"
                                    },
                                    {
                                        "title": "Invisible Device",
                                        "image": "mic"
                                    }
                                ]
                            },
                            {
                                "section": "Jogos/Entretenimentos",
                                "trailing": "game",
                                "items": [
                                    {
                                        "title": "Forca",
                                        "image": "forca"
                                    },
                                    {
                                        "title": "Cara ou Coroa",
                                        "image": "caracoroa"
                                    },
                                    {
                                        "title": "Jogo da Velha",
                                        "image": "velha"
                                    },
                                    {
                                        "title": "Pedra/Papel/Tesoura",
                                        "image": "mic"
                                    },
                                    {
                                        "title": "Dados",
                                        "image": "mic"
                                    }
                                ]
                            },
                            {
                                "section": "SUB MENUS + SUB MENUS TESTE",
                                "trailing": "i",
                                "items": [
                                    {
                                        "title": "Pergunte ao ChatGPR",
                                        "image": "forca"
                                    },
                                    {
                                        "title": "Horóscopo do Dia",
                                        "image": "forca"
                                    },
                                    {
                                        "title": "Clima Tempo",
                                        "image": "forca"
                                    },
                                    {
                                        "title": "Cotações",
                                        "image": "forca",
                                        "subMenu": [
                                            {
                                                "section": "Europa",
                                                "trailing": "help",
                                                "items": [
                                                    {
                                                        "title": "Euro",
                                                        "image": "alcool"
                                                    },
                                                    {
                                                        "title": "Libras Esterlinas",
                                                        "image": "libras"
                                                    },
                                                    {
                                                        "title": "Alemao",
                                                        "image": "alemao"
                                                    }
                                                ]
                                            },
                                            {
                                                "section": "Asia",
                                                "trailing": "asia",
                                                "items": [
                                                    {
                                                        "title": "Xiaome rs",
                                                        "image": "gas"
                                                    },
                                                    {
                                                        "title": "Sei lá mais qual",
                                                        "image": "gas"
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        "title": "Próximos Feriados",
                                        "image": "forca"
                                    },
                                    {
                                        "title": "Recomendações de Filme",
                                        "image": "forca"
                                    }
                                ]
                            },
                            {
                                "section": "Auto Ajuda",
                                "trailing": "help",
                                "items": [
                                    {
                                        "title": "Músicas e Citações",
                                        "image": "forca"
                                    }
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "section": "Recentes - SEGUNDA SECTION",
                "trailing": "heart",
                "items": [
                    {
                        "title": "Regra de 3",
                        "image": "mic",
                        "trailing": "heart"
                    },
                    {
                        "title": "Alcool ou Gasolina",
                        "image": "mic.fil",
                        "subMenu": [
                            {
                                "section": "Alcool",
                                "trailing": "help",
                                "items": [
                                    {
                                        "title": "Falar Alcool",
                                        "image": "alcool"
                                    }
                                ]
                            },
                            {
                                "section": "Gasolina",
                                "trailing": "gas",
                                "items": [
                                    {
                                        "title": "Falar Gasolina",
                                        "image": "gas"
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "title": "Fita Métrica",
                        "image": "mic.fil",
                        "trailing": "heart"
                    }
                ]
            },
            {
                "section": "Cofigurações - TERCEIRA SECTION",
                "trailing": "heart",
                "items": [
                    {
                        "title": "Perfil",
                        "image": "mic"
                    },
                    {
                        "title": "Notificações",
                        "image": "mic.fil"
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
        print("\(tab)#", menu.section ?? ""/*, "-" , menu.trailing ?? ""*/)
        
        menu.items?.forEach({ item in
            print("\(itemTab)->", /*item.image ?? "", "-" ,*/ item.title ?? "")
            
            if item.subMenu?.count ?? 0 > 0 {
                printaDireitoSaporra(item.subMenu ?? [], tab, itemTab)
            }
            
        })
        
        print("")
    }
    
    
}


