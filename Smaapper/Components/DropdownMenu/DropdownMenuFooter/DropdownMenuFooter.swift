//
//  DropdownMenuFooter.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import UIKit

class DropdownMenuFooter: DropdownMenu {
    
    override init() {
        super.init()
        addElements()
        configConstraint()
        configCornerRadius()
        configFooter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.backgroundColor = UIColor.HEX("#343a3d")
        sv.layer.zPosition = 1
        
        return sv
    }()
    
    
//  MARK: - SET Properties
    
    
    
    
    
    
    
    
    
//  MARK: - Private Functions Area
    
    private func addElements() {
        stackView.add(insideTo: self)
    }
    
    private func configConstraint() {
        stackView.makeConstraints { make in
            make.setBottom.setLeading.setTrailing.equalToSuperView
                .setHeight.equalToConstant(60)
        }
    }
    
    private func configFooter() {
        DispatchQueue.main.async {
            _ = self.setPaddingMenu(top: self.paddingMenu?.top ?? 0,
                                    left: self.paddingMenu?.left ?? 0,
                                    bottom: 60,
                                    right: self.paddingMenu?.right ?? 0)
        }
    }

    private func configCornerRadius() {
        DispatchQueue.main.async {
            self.stackView.layer.cornerRadius = self.layer.cornerRadius
            _ = self.stackView.setBorder { build in
                build.setWhichCornersWillBeRounded([.bottom])
            }
        }
        
        _ = stackView.setGradient { build in
            build
                    .setColor([UIColor.HEX("#13547a"),UIColor.HEX("#50827c")]) // -> Aqua Splash
//                    .setColor([UIColor.HEX("#df667b"),UIColor.HEX("#df6e9d")]) // -> Passionate Bed
//                    .setColor([UIColor.HEX("#09203f"),UIColor.HEX("#3e5a70")]) // -> Eternal Constance
//                    .setColor([UIColor.HEX("#009245"),UIColor.HEX("#FCEE21")]) // -> Luscious Lime
//                    .setColor([UIColor.HEX("#662D8C"),UIColor.HEX("#ED1E79")]) // -> Purple Lake **
//                    .setColor([UIColor.HEX("#ED1E79"),UIColor.HEX("#662D8C")]) // -> Purple Lake INVERTIDO** <-
//                    .setColor([UIColor.HEX("#067D68"),UIColor.HEX("#50D5B7")]) // -> PENSAR
//                    .setColor([UIColor.HEX("#2E3192"),UIColor.HEX("#1BFFFF")]) // -> Ocean Blue
//                    .setColor([UIColor.HEX("#667eea"),UIColor.HEX("#764ba2")]) // -> Plum Plate *****
                    .setColor([UIColor.HEX("#ec9355"),UIColor.HEX("#ff6b00")]) // --> top demaisssssss
//                    .setColor([UIColor.HEX("#ff6b00"),UIColor.HEX("#ec9355")]) // --> top demaisssssss - invertido
//                    .setColor([UIColor.HEX("#f92900"),UIColor.HEX("#b02300")]) //--> Favorito de todos
//                .setColor([UIColor.HEX("#FF512F"),UIColor.HEX("#DD2476")]) // -> Bloody Mary VENCEDOR
                .setAxialGradient(.leftTopToRightBottom)
                .apply()
        }

    }
    
    
}

