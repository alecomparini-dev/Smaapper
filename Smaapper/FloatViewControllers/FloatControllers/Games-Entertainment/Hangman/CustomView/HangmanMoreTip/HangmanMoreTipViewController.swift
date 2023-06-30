//
//  HangmanMoreTipViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/06/23.
//

import UIKit


class HangmanMoreTipViewController: HangmanMoreTipView {
    
    private let tip: [String]
    
    init(_ tip: [String]) {
        self.tip = tip
        super.init()
        initialization()
    }
        
    private func initialization() {
        configListTip()
    }
    
    
//  MARK: - PRIVATE Area
    private func configListTip() {
        
    }
    
}
