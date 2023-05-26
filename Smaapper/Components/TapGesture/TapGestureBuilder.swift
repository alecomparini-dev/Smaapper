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
    
    private(set) var tapGesture: TapGesture = TapGesture()
    private let component: UIView
    
    init(_ component: UIView) {
        self.component = component
        self.initialization()
    }
    
    private func initialization() {
        enableUserInteractionComponent()
        setCancelsTouchesInView(false)
        configTapGestureDelegate()
        createTapGesture()
        addTapOnComponent()
    }

//  MARK: - GET Properties
    var view: TapGesture { self.tapGesture }

    
//  MARK: - Set Properties

    @discardableResult
    func setNumberOfTapsRequired(_ numberOfTaps: Int) -> Self {
        tapGesture.numberOfTapsRequired = numberOfTaps
        return self
    }
    
    @discardableResult
    func setNumberOfTouchesRequired(_ numberOfTouches: Int) -> Self {
        tapGesture.numberOfTouchesRequired = numberOfTouches
        return self
    }
    
    @discardableResult
    func setCancelsTouchesInView(_ cancel: Bool ) -> Self {
        tapGesture.cancelsTouchesInView = cancel
        return self
    }
    
    @discardableResult
    func setAction(touchBegan closure: @escaping touchGestureAlias) -> Self {
        self._touchBegan = closure
        return self
    }
    
    @discardableResult
    func setAction(touchMoved closure: @escaping touchGestureAlias) -> Self {
        self._touchMoved = closure
        return self
    }
    
    @discardableResult
    func setAction(touchEnded closure: @escaping touchGestureAlias) -> Self {
        self._touchEnded = closure
        return self
    }
    
    @discardableResult
    func setAction(touchCancelled closure: @escaping touchGestureAlias) -> Self {
        self._touchCancelled = closure
        return self
    }
    
       
    
//  MARK: - Private Area
    private func enableUserInteractionComponent() {
        self.component.isUserInteractionEnabled = true
    }
    
    private func createTapGesture() {
        self.tapGesture.addTarget(self, action: #selector(objcTapGesture))
    }
    
    private func addTapOnComponent() {
        self.component.addGestureRecognizer(self.tapGesture)
    }
    
    private func configTapGestureDelegate() {
        tapGesture.tapGestureDelegate = self
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
