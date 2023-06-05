//
//  FloatWindowsActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit


class FloatWindowsActions: BaseActions {
    typealias floatWindowAlias = (_ floatWindow: FloatWindowViewController) -> Void
    
    private let floatWindow: FloatWindowViewController
    
    init(_ floatWindow: FloatWindowViewController) {
        self.floatWindow = floatWindow
        super.init(floatWindow)
    }
    

}
