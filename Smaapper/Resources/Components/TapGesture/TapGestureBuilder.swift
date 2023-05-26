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
    
    private(set) var tapGesture: TapGesture?
    private let component: UIView
    
    init(_ component: UIView) {
        self.component = component
        self.initialization()
    }
    
    private func initialization() {
        enableUserInteractionComponent()
        createTapGesture()
        setCancelsTouchesInView(false)
        addTapOnComponent()
        configTapGestureDelegate()
        
    }

//  MARK: - GET Properties
    var view: TapGesture { self.tapGesture ?? TapGesture() }

    
//  MARK: - Set Properties

    @discardableResult
    func setNumberOfTapsRequired(_ numberOfTaps: Int) -> Self {
        self.tapGesture?.numberOfTapsRequired = numberOfTaps
        return self
    }
    
    @discardableResult
    func setNumberOfTouchesRequired(_ numberOfTouches: Int) -> Self {
        self.tapGesture?.numberOfTouchesRequired = numberOfTouches
        return self
    }
    
    @discardableResult
    func setCancelsTouchesInView(_ cancel: Bool ) -> Self {
        self.tapGesture?.cancelsTouchesInView = cancel
        return self
    }
    
    @discardableResult
    func setAction(touchBegan closure: (@escaping touchGestureAlias)) -> Self {
        self._touchBegan = closure
        self.addStatesEnabled(.began)
        return self
    }
    
    @discardableResult
    func setAction(touchEnded closure: (@escaping touchGestureAlias)) -> Self {
        self._touchEnded = closure
        self.addStatesEnabled(.ended)
        return self
    }
    
    @discardableResult
    func setAction(touchMoved closure: (@escaping touchGestureAlias)) -> Self {
        self._touchMoved = closure
        self.addStatesEnabled(.changed)
        return self
    }
    
    @discardableResult
    func setAction(touchCancelled closure: (@escaping touchGestureAlias)) -> Self {
        self._touchCancelled = closure
        self.addStatesEnabled(.cancelled)
        return self
    }
    
    @discardableResult
    func setIsEnabled(_ enabled: Bool ) -> Self {
        self.tapGesture?.isEnabled = enabled
        return self
    }
       
    
//  MARK: - Private Area
    private func enableUserInteractionComponent() {
        self.component.isUserInteractionEnabled = true
    }
    
    private func createTapGesture() {
        self.tapGesture = TapGesture(target: self, action: #selector(objcTapGesture))
    }
    
    private func addTapOnComponent() {
        if let tapGesture {
            self.component.addGestureRecognizer(tapGesture)
        }
    }
    
    private func configTapGestureDelegate() {
        tapGesture?.tapGestureDelegate = self
    }
    
    private func addStatesEnabled(_ state: UIGestureRecognizer.State) {
        self.tapGesture?.statesEnabled.append(state)
    }

    
//  MARK: - Objc Function Area
    @objc
    private func objcTapGesture(sender: UITapGestureRecognizer) { }
    
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

