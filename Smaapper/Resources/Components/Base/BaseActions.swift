//
//  BaseActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit


class BaseActions {
    
    typealias touchBaseActionClosureAlias = (_ component: UIView ) -> Void
    
    private var baseBuilder: BaseBuilder
    
    init(_ baseBuilder: BaseBuilder) {
        self.baseBuilder = baseBuilder
    }
    
    
//  MARK: - SET Actions
    
    @discardableResult
    func setAction(touch closure: @escaping touchBaseActionClosureAlias) -> Self {
        self.baseBuilder.setTapGesture { build in
            build
                .setTouchEnded { [weak self] tapGesture in
                    guard let self else {return}
                    closure(self.baseBuilder.component)
                }
            
        }
        return self
    }
    
}
