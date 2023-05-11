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
            .setGradient { build in
                build
                    .setColor([UIColor.HEX("#17191a"), UIColor.HEX("#17191a"),  UIColor.HEX("#17191a")])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
        }
    }
    
    
}

