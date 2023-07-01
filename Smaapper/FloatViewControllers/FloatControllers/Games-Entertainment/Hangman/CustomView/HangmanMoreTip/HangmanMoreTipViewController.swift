//
//  HangmanMoreTipViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/06/23.
//

import UIKit


class HangmanMoreTipViewController: ViewBuilder {
    
    private var tip: [String] = []

    lazy var customView: HangmanMoreTipView = {
        let view = HangmanMoreTipView()
        return view
    }()
    
    override init() {
        super.init()
        loadCustomView()
    }
    
    
//  MARK: - SET Properties
    
    
    
//  MARK: - PRIVATE Area
    private func loadCustomView() {
        self.view = customView
    }
    
    private func configListTip() {
        
    }
    
}
