//
//  DropdownMenuFooter.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class DropdownMenuFooter: DropdownMenu {
    
    private var _footerHeight: CGFloat = 50
    private var _footerGradient: Gradient?
    private var _componentsFooter: [UIView] = []
    
    
//  MARK: - Components
    lazy var stackView: Stack = {
        let sv = Stack()
            .setDistribution(.fillEqually)
            .setAxis(.horizontal)
            .setAlignment(.center)
            .setSpacing(5)
        return sv
    }()
    

//  MARK: - GET Attributes
    var footerHeight: CGFloat {
        get { self._footerHeight }
        set { self._footerHeight = newValue }
    }
    
    var footerGradient: Gradient? {
        get { self._footerGradient }
        set { self._footerGradient = newValue }
    }
    
    var componentsFooter: [UIView] {
        get { self._componentsFooter }
        set { self._componentsFooter = newValue }
    }

    
}
