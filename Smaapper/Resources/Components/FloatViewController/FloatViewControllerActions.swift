//
//  FloatWindowsActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit


class FloatViewControllerActions: BaseActions {
    typealias floatWindowAlias = (_ floatWindow: FloatViewController) -> Void
    
    private let floatWindow: FloatViewController
    
    init(_ floatWindow: FloatViewController) {
        self.floatWindow = floatWindow
        super.init(floatWindow)
    }
    
    
    

}
