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
    
    
//  MARK: - SET Properties
    
    
    
//  MARK: - PRIVATE Area
    private func loadCustomView() {
        self.view = customView
    }
    
    private func configListTip() {
        let section = createSection()
        customView.tipList.populateSection(section)
        customView.tipList.isShow = true
    }
    
    private func createSection() -> Section {
        let section = Section(
            leftView: UIView(frame: .zero),
            middleView: LabelBuilder("Tips")
                .setFont(UIFont.systemFont(ofSize: 18, weight: .semibold))
                .setColor(Theme.shared.currentTheme.onSurfaceVariant)
                .view
        )
        return section
    }
    
}
