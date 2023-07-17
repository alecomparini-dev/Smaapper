//
//  HangmanMoreTipView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/06/23.
//

import UIKit

protocol HangmanMoreTipViewDelegate: AnyObject {
    func didSelectRow(_ section: Int, _ row: Int )
    func closeMoreTipTapped()
}

class HangmanMoreTipView: View {
    
    weak var delegate: HangmanMoreTipViewDelegate?
    
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
    
    lazy var tipList: ListBuilder = {
        let list = ListBuilder(.grouped)
            .setSeparatorStyle(.singleLine)
            .setRowHeight(45)
            .setSectionHeaderHeight(40)
            .setSectionFooterHeight(0)
            .setWidthLeftColumnCell(10)
            .setShowsVerticalScrollIndicator(false)
            .setActions({ build in
                build
                    .setDidSelectRow { [weak self] section, row in
                        self?.delegate?.didSelectRow(section, row)
                    }
            })
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(15)
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
        delegate?.closeMoreTipTapped()
    }
    
//  MARK: - PRIVATE Area
    private func addElements() {
        tipList.add(insideTo: self)
        closeMoreTipButton.add(insideTo: self)
    }
    
    private func configConstraints() {
        tipList.applyConstraint()
        closeMoreTipButton.applyConstraint()
    }
    
    
}
