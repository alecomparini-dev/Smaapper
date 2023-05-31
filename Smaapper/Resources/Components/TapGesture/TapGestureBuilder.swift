//
//  TapGestureBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit

class TapGestureBuilder {
    
    typealias touchGestureAlias = (_ tapGesture: TapGesture) -> Void
    
    private var _touchBegan: touchGestureAlias?
    private var _touchMoved: touchGestureAlias?
    private var _touchEnded: touchGestureAlias?
    private var _touchCancelled: touchGestureAlias?
    
    private var tapGesture: TapGesture
    private weak var component: UIView?
    
    init(_ component: UIView) {
        self.component = component
        self.tapGesture = TapGesture(component)
        self.initialization()
    }
    
    private func initialization() {
        enableUserInteractionComponent()
        setCancelsTouchesInView(false)
        configTapGestureDelegate()
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
    func setTouchBegan(_ closure: @escaping touchGestureAlias) -> Self {
        self._touchBegan = closure
        return self
    }
    
    @discardableResult
    func setTouchEnded(_ closure: @escaping touchGestureAlias) -> Self {
        self._touchEnded = closure
        return self
    }
    
    @discardableResult
    func setTouchMoved(_ closure: @escaping touchGestureAlias) -> Self {
        self._touchMoved = closure
        return self
    }
    
    @discardableResult
    func setTouchCancelled(_ closure: @escaping touchGestureAlias) -> Self {
        self._touchCancelled = closure
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
    
    func touchBegan(_ tapGesture: TapGesture) {
        self._touchBegan?(tapGesture)
    }
    
    func touchMoved(_ tapGesture: TapGesture) {
        self._touchMoved?(tapGesture)
    }
    
    func touchEnded(_ tapGesture: TapGesture) {
        self._touchEnded?(tapGesture)
    }
    
    func touchCancelled(_ tapGesture: TapGesture) {
        self._touchCancelled?(tapGesture)
    }
    
}

