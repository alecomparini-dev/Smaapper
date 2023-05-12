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
    private var componentsFooter: [UIView] = []
    
    
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
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 5
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
    
    func setPaddingFooter() -> Self {
        
        return self
    }
    
    func setComponentView(_ componentView: UIView) -> Self {
        self.componentsFooter.append(componentView)
        return self
    }
    
    
    
//  MARK: - APPLY Dropdown Footer
    override func show() {
        applyOnceConfig()
        super.show()
    }
    
    
//  MARK: - Private Functions Area
    
    private func createView() -> View {
        let view = View()
            .setConstraints { build in
                build.setTop.setBottom.equalToSuperView
            }
        return view
    }
    
    
    private func addComponentsOnFooter() {
        self.componentsFooter.forEach { comp in
//            let view = createView()
//            comp.add(insideTo: view)
            self.stackView.addArrangedSubview(comp)
//            view.applyConstraint()
            comp.makeConstraints { make in
//                make.setPin.equalToSuperView(5)
                make.setTop.setBottom.equalToSuperView
            }
        }
    }
    
    
    private func applyOnceConfig() {
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
        addComponentsOnFooter()
        
        _ = stackView
//            .setShadow({ build in
//                build
//                    .setColor(UIColor.HEX("#ec9355"))
//                    .setOffset(width: 150, height: -50)
//                    .setBlur(60)
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
            stackView.layoutIfNeeded()
            _ = footerGradient.apply(stackView)
        }
        
    }
    
    
}

