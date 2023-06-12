//
//  TitleFloatView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

class TitleFloatView: ViewBuilder {
    
    private var closeClosure: Selector
    private var minimizeClosure: Selector
    
    private let title: String
    private let logo: String
    private let target: Any
    
    init(title: String = "", logo: String, target: Any, closeClosure: Selector, minimizeClosure: Selector ) {
        self.title = title
        self.logo = logo
        self.closeClosure = closeClosure
        self.minimizeClosure = minimizeClosure
        self.target = target
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
       
    
//  MARK: - LAZY Area
    
    lazy var closeButton: ButtonImageBuilder = {
        let btn = ButtonImageBuilder(UIImageView(image: UIImage(systemName: "xmark")))
            .setImageSize(10)
            .setImageWeight(.semibold)
            .setTitleAlignment(.center)
            .setImageColor(Theme.shared.currentTheme.onSurfaceVariant.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(7)
                    .setSize.equalToConstant(24)
                    .setLeading.equalToSuperView(8)
            }
            .setActions { build in
                build
                    .setTarget(target, self.closeClosure, .touchUpInside)
            }
        return btn
    }()
    
    lazy var logoImageView: ImageViewBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: self.logo))
            .setSize(14)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(closeButton.view)
                    .setLeading.equalTo(closeButton.view, .trailing)
                    .setWidth.equalToConstant(22)
            }
        return img
    }()
    
    
    lazy var titleLabel: LabelBuilder = {
        let label = LabelBuilder(self.title)
            .setFont(UIFont.systemFont(ofSize: 12, weight: .thin))
            .setColor(Theme.shared.currentTheme.onSurface)
            .setTextAlignment(.natural)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(logoImageView.view)
                    .setLeading.equalTo(logoImageView.view, .trailing, 3)
                    .setTrailing.equalTo(minimizeButton.view, .leading, -5)
                    .setHeight.equalToConstant(25)
            }
        return label
    }()
    
    
    lazy var minimizeButton: ButtonImageBuilder = {
        let btn = ButtonImageBuilder(UIImageView(image: UIImage(systemName: "minus.square.fill")))
            .setImageSize(14)
            .setImageWeight(.semibold)
            .setTitleAlignment(.center)
            .setImageColor(Theme.shared.currentTheme.onSurfaceVariant.withAlphaComponent(0.8))
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(closeButton.view)
                    .setSize.equalToConstant(25)
                    .setTrailing.equalToSuperView(-7)
            }
            .setActions { build in
                build
                    .setTarget(self.target, self.minimizeClosure, .touchUpInside)
            }
        return btn
    }()
    
    
    
//  MARK: - PRIVATE Area
    
    private func addElements() {
        closeButton.add(insideTo: self.view)
        logoImageView.add(insideTo: self.view)
        titleLabel.add(insideTo: self.view)
        minimizeButton.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        closeButton.applyConstraint()
        logoImageView.applyConstraint()
        titleLabel.applyConstraint()
        minimizeButton.applyConstraint()
    }
    
}
