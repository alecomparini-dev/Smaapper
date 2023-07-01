//
//  HangmanMoreTipView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/06/23.
//

import UIKit

protocol HangmanMoreTipViewDelegate: AnyObject {
    func didSelectRow(_ section: Int, _ row: Int )
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
        setBackgroundColor(.red)
    }
    
//  MARK: - LAZY Area
    
    lazy var tipList: ListBuilder = {
        let list = ListBuilder(.insetGrouped)
            .setSeparatorStyle(.none)
            .setRowHeight(50)
            .setShowsVerticalScrollIndicator(false)
            .setWidthLeftColumnCell(10)
            .setActions({ build in
                build
                    .setDidSelectRow { [weak self] section, row in
                        self?.delegate?.didSelectRow(section, row)
                    }
            })
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return list
    }()
    
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        tipList.add(insideTo: self)
    }
    
    private func configConstraints() {
        tipList.applyConstraint()
    }
    
    
}
