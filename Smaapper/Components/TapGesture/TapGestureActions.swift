//
//  TapGestureActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit


class TapGestureActions {
    typealias touchGestureActionsAlias = (_ tapGesture: TapGesture) -> Void
    
    private var _touchBegan: touchGestureActionsAlias?
    private var _touchMoved: touchGestureActionsAlias?
    private var _touchEnded: touchGestureActionsAlias?
    private var _touchCancelled: touchGestureActionsAlias?
    
    private let tapGestureBuilder: TapGestureBuilder
    
    init(_ tapGestureBuilder: TapGestureBuilder) {
        self.tapGestureBuilder = tapGestureBuilder
    }
    

    

}

