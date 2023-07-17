//
//  ShowResultPredictionView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import UIKit

protocol ShowResultPredictionViewDelegate: AnyObject {
    func closeResultPrediction()
}

class ShowResultPredictionView: View {
    
    weak var delegate: ShowResultPredictionViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
//  MARK: - LAZY Area
    
    lazy var beerLabel: LabelBuilder = {
        let label = LabelBuilder("HEINEKEN")
            .setFont(UIFont.systemFont(ofSize: 25))
            .setColor(Theme.shared.currentTheme.onSurface)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView
                    .setHeight.equalToConstant(30)
            }
        return label
    }()
    
    lazy var resultList: ListBuilder = {
        let list = ListBuilder(.grouped)
            .setSeparatorStyle(.singleLine)
            .setRowHeight(45)
            .setSectionHeaderHeight(40)
            .setSectionFooterHeight(0)
            .setWidthLeftColumnCell(10)
            .setShowsVerticalScrollIndicator(false)
            .setConstraints { build in
                build
                    .setTop.equalTo(beerLabel.view, .bottom, 5)
                    .setPinBottom.equalToSuperView(10)
            }
        return list
    }()
    
    lazy var closeMoreTipButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "xmark"))
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
        delegate?.closeResultPrediction()
    }
    
//  MARK: - PRIVATE Area
    private func addElements() {
        resultList.add(insideTo: self)
        closeMoreTipButton.add(insideTo: self)
    }
    
    private func configConstraints() {
        resultList.applyConstraint()
        closeMoreTipButton.applyConstraint()
    }
    
    
}
