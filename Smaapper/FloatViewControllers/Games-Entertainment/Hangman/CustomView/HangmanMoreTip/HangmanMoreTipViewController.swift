//
//  HangmanMoreTipViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/06/23.
//

import UIKit

class HangmanMoreTipViewController: ViewBuilder {
    
    private var tips: [String] = []
    
    lazy var customView: HangmanMoreTipView = {
        let view = HangmanMoreTipView()
        return view
    }()
    
    init(_ tips: [String]) {
        self.tips = tips
        super.init()
        initialization()
    }
    
    private func initialization() {
        loadCustomView()
        configListTip()
    }

//  MARK: - SET DELEGATE
    func setDelegate(_ delegate: HangmanMoreTipViewDelegate) {
        customView.delegate = delegate
    }
    
    
//  MARK: - PRIVATE Area
    private func loadCustomView() {
        self.view = customView
    }
    
    private func configListTip() {
        let section = createSection()
        customView.tipList.populateSection(section)
        customView.tipList.isShow = true
        createRow(section)
    }
    
    private func createSection() -> Section {
        let section = Section(
            leftView: UIView(frame: .zero),
            middleView: LabelBuilder(" Tips")
                .setFont(UIFont.systemFont(ofSize: 18, weight: .semibold))
                .setColor(Theme.shared.currentTheme.onSurfaceVariant)
                .view
        )
        return section
    }
    
    private func createRow(_ section: Section) {
        tips.forEach { tip in
            let row = Row(
                leftView: UIView(),
                middleView:
                    LabelBuilder(tip)
                    .setNumberOfLines(2)
                    .setFont(UIFont.systemFont(ofSize: 14, weight: .regular))
                    .setColor(Theme.shared.currentTheme.onSurface)
                    .view,
                rightView: nil)
            customView.tipList.populateRowInSection(section, row)
        }
    }
    
    
}

