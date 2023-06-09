//
//  ViewBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class ViewBuilder: BaseBuilder {
    
    private(set) var actions: ViewActions?
    private var _view: View
    
    var view: View {
        get { self._view }
        set {
            self._view = newValue
            super.component = self._view
        }
    }
    
    init() {
        self._view = View(frame: .zero)
        super.init(self._view)
    }
    
    init(frame: CGRect) {
        self._view = View(frame: frame)
        super.init(self._view)
    }
    
    
//  MARK: - SET Properties
    @discardableResult
    func setSize(width: Int, height: Int) -> Self {
        self.view.frame.size = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func setSize(_ size: CGSize) -> Self {
        self.view.frame.size = size
        return self
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setActions(_ action: (_ build: ViewActions) -> ViewActions) -> Self {
        if let actions = self.actions {
            self.actions = action(actions)
            return self
        }
        self.actions = action(ViewActions(self))
        return self
    }
        
    
}
