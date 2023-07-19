//
//  ShowResultBeerView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import UIKit

protocol ShowResultBeerViewDelegate: AnyObject {
    func closeResultBeer()
}

class ShowResultBeerView: View {
    weak var delegate: ShowResultBeerViewDelegate?
    
    init(_ result: String) {
        super.init()
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addElements()
        configConstraints()
        configStyleView()
    }
    
    
//  MARK: - LAZY Area

    lazy var beerLabel: LabelBuilder = {
        let label = LabelBuilder()
            .setFont(UIFont.systemFont(ofSize: 28))
            .setNumberOfLines(2)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setTextAlignment(.natural)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(15)
                    .setLeading.equalToSuperView(15)
                    .setTrailing.equalToSuperView(40)
            }
        return label
    }()
    
    lazy var underLineTitle: ViewBuilder = {
       var view = ViewBuilder()
            .setGradient({ build in
                build
                    .setGradientColors(Theme.shared.currentTheme.primaryGradient)
                    .setAxialGradient(.leftToRight)
                    .apply()
            })
            .setBorder({ build in
                build.setCornerRadius(2)
            })
            .setShadow({ build in
                build
                    .setOffset(width: 3, height: 3)
                    .setColor(.black.withAlphaComponent(0.8))
                    .setOpacity(1)
                    .setRadius(3)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(beerLabel.view, .bottom, 2)
                    .setLeading.equalTo(beerLabel.view, .leading, 1)
                    .setHeight.equalToConstant(2)
                    .setWidth.equalToConstant(60)
            }
        return view
    }()
    
    lazy var resultList: ListBuilder = {
        let list = ListBuilder(.grouped)
            .setBackgroundColorCell(Theme.shared.currentTheme.surfaceContainerLow.withAlphaComponent(0.7))
            .setSeparatorStyle(.none)
            .setRowHeight(48)
            .setSectionHeaderHeight(55)
            .setSectionFooterHeight(0)
            .setWidthLeftColumnCell(10)
            .setShowsVerticalScrollIndicator(false)
            .setConstraints { build in
                build
                    .setTop.equalTo(beerLabel.view, .bottom, 15)
                    .setPinBottom.equalToSuperView(10)
            }
        return list
    }()
    
    lazy var closeResultBeerButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: K.WhatBeer.Images.closeResultBeer))
        let btn = ButtonImageBuilder(img.view)
            .setImageSize(15)
            .setImageColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setConstraints { build in
                build
                    .setTop.setTrailing.equalToSuperView(10)
                    .setSize.equalToConstant(30)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(closeMoreTipTapped), .touchUpInside)
            }
        return btn
    }()
    
    
//  MARK: - @OBJC Area
    @objc private func closeMoreTipTapped() {
        delegate?.closeResultBeer()
    }
    
//  MARK: - PUBLIC Area
    func configResultListConstraint() {
        resultList.applyConstraint()
    }
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        beerLabel.add(insideTo: self)
        underLineTitle.add(insideTo: self)
        resultList.add(insideTo: self)
        closeResultBeerButton.add(insideTo: self)
    }
    
    private func configConstraints() {
        beerLabel.applyConstraint()
        underLineTitle.applyConstraint()
        closeResultBeerButton.applyConstraint()
    }
    
    private func configStyleView() {
        configBackgroundColor()
        configBorder()
    }

    private func configBorder() {
        makeBorder { make in
            make
                .setCornerRadius(20)
        }
    }
    
    private func configBackgroundColor() {
        setBackgroundColor(Theme.shared.currentTheme.backgroundColor.withAlphaComponent(0.9))
    }
    
}
