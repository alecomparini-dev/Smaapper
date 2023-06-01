//
//  ViewBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class ViewBuilder: BaseBuilder {
    
    private(set) var actions: ViewActions?
    
    var view: View
    
    init() {
        self.view = View(frame: .zero)
        super.init(self.view)
    }
    
    init(frame: CGRect) {
        self.view = View(frame: frame)
        super.init(self.view)
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setActions(_ action: (_ build: ViewActions) -> ViewActions) -> Self {
        self.actions = action(ViewActions(self))
        return self
    }
        
    
}
