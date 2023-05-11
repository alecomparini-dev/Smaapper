//
//  DropdownMenuFooter.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 10/05/23.
//

import UIKit

class DropdownMenuFooter: DropdownMenu {
    
    private var alreadyApplied = false
    
    private var footerHeight: CGFloat = 50
    private var footerGradient: Gradient?
    
//  MARK: - Initializers
    
    override init() {
        super.init()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//  MARK: - Components
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
//  MARK: - SET Properties
    func setFooterHeight(_ footerHeight: CGFloat) -> Self {
        self.footerHeight = footerHeight
        return self
    }
    
    func setFooterGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        self.footerGradient = gradient(Gradient(stackView))
        return self
    }
    
    override func show() {
        applyOnce()
        super.show()
    }
    
    
//  MARK: - Private Functions Area
    
    private func applyOnce() {
        if !alreadyApplied {
            configDropdownMenuFooter()
            self.alreadyApplied = true
        }
    }
    
    private func addElements() {
        stackView.add(insideTo: self)
    }
    
    private func configDropdownMenuFooter() {
        configConstraint()
        configCornerRadius()
        configFooter()
        configGradient()
        
        _ = stackView
//            .setShadow({ build in
//                build
//                    .setColor(UIColor.HEX("#ec9355"))
//                    .setOffset(width: 150, height: -50)
//                    .setRadius(80)
//                    .setOpacity(0.7)
//                    .setCornerRadius(0)
//                    .setShadowHeight(80)
//                    .setShadowWidth(50)
//                    .apply()
//            })
            .setShadow({ build in
                build
                    .setColor(.black)
                    .setOffset(width: 0, height: -5)
                    .setBlur(5)
                    .setOpacity(0.8)
                    .setCornerRadius(0)
                    .setShadowHeight(10)
                    .apply()
            })
            
    }
    
    private func configConstraint() {
        stackView.makeConstraints { make in
            make.setBottom.setLeading.setTrailing.equalToSuperView
                .setHeight.equalToConstant(self.footerHeight)
        }
    }
    
    private func configFooter() {
        _ = self.setPaddingMenu(top: self.paddingMenu?.top ?? 0,
                                left: self.paddingMenu?.left ?? 0,
                                bottom: self.footerHeight,
                                right: self.paddingMenu?.right ?? 0)
    }

    private func configCornerRadius() {
        DispatchQueue.main.async {
            self.stackView.layer.cornerRadius = self.layer.cornerRadius
            _ = self.stackView.setBorder { build in
                build.setWhichCornersWillBeRounded([.bottom])
            }
        }
    }
    
    private func configGradient() {
        if let footerGradient = self.footerGradient {
//            stackView.setNeedsLayout()
            stackView.layoutIfNeeded()
            _ = footerGradient.apply(stackView)
        }
        
    }
    
    
}

