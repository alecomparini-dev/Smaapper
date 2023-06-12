//
//  TapGestureBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit

class TapGestureBuilder {
    
    typealias touchGestureAlias = (_ tapGesture: TapGesture) -> Void
    
    private var touchMoved: touchGestureAlias?
    private var touchEnded: touchGestureAlias?
    private var touchCancelled: touchGestureAlias?
    
    private var tapGesture: TapGesture
    private weak var component: UIView?
    
    init(_ component: UIView) {
        self.component = component
        self.tapGesture = TapGesture(component)
        self.initialization()
    }
    
    private func initialization() {
        enableUserInteractionComponent()
        configTapGestureDelegate()
        setCancelsTouchesInView(false)
    }
    
    
    //  MARK: - Set Properties
    
    @discardableResult
    func setNumberOfTapsRequired(_ numberOfTaps: Int) -> Self {
        self.tapGesture.numberOfTapsRequired = numberOfTaps
        return self
    }
    
    @discardableResult
    func setNumberOfTouchesRequired(_ numberOfTouches: Int) -> Self {
        self.tapGesture.numberOfTouchesRequired = numberOfTouches
        return self
    }
    
    @discardableResult
    func setCancelsTouchesInView(_ cancel: Bool ) -> Self {
        self.tapGesture.cancelsTouchesInView = cancel
        return self
    }
    
    @discardableResult
    func setTouchEnded(_ closure: @escaping touchGestureAlias) -> Self {
        self.touchEnded = closure
        return self
    }
    
    @discardableResult
    func setTouchMoved(_ closure: @escaping touchGestureAlias) -> Self {
        self.touchMoved = closure
        return self
    }
    
    @discardableResult
    func setTouchCancelled(_ closure: @escaping touchGestureAlias) -> Self {
        self.touchCancelled = closure
        return self
    }
    
    @discardableResult
    func setIsEnabled(_ enabled: Bool ) -> Self {
        self.tapGesture.isEnabled = enabled
        return self
    }
    
    
    //  MARK: - Private Area
    private func enableUserInteractionComponent() {
        self.component?.isUserInteractionEnabled = true
    }
    
    private func configTapGestureDelegate() {
        self.tapGesture.tapGestureDelegate = self
    }
    
}

//  MARK: - Extension TapGestureActionsDelegate
extension TapGestureBuilder: TapGestureDelegate {
    
    func touchMoved(_ tapGesture: TapGesture) {
        self.touchMoved?(tapGesture)
    }
    
    func touchEnded(_ tapGesture: TapGesture) {
        self.touchEnded?(tapGesture)
    }
    
    func touchCancelled(_ tapGesture: TapGesture) {
        self.touchCancelled?(tapGesture)
    }
    
}

