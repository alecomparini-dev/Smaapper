//
//  TapGesture.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/05/23.
//

import UIKit

class TapGesture {
    typealias closureTapGestureAlias = (_ tapGesture: TapGesture) -> Void
    
    enum GestureRelativeTo {
        case superview
        case window
    }
    
    private var action: closureTapGestureAlias?
    
    private var onTapGesture: OnTapGesture?
    private var states: [UIGestureRecognizer.State] = []
    private var gestureRelative: TapGesture.GestureRelativeTo = .superview
    private weak var component: UIView?
    
    
//  MARK: - Initializers Area
    
    init(_ component: UIView) {
        self.component = component
        self.initialization()
    }
    
    private func initialization() {
        setDefaultValues()
        configUserInteractionComponent()
        createOnTapGesture()
    }

    
//  MARK: - GET Function
    func getTouchedPositionRelative(to relative: TapGesture.GestureRelativeTo) -> CGPoint {
        guard let onTapGesture = self.onTapGesture else {return CGPoint()}
        switch relative {
            case .superview:
                return onTapGesture.touchPositionSuperView
            case .window:
                return onTapGesture.touchPositionWindow
        }
    }
    
    func getTouchedComponent() -> UIView {
        return self.component ?? UIView()
    }
    
    func getState() -> UIGestureRecognizer.State {
        guard let onTapGesture = self.onTapGesture else {return .failed}
        return onTapGesture.getState
    }
    

//  MARK: - Set Properties

    @discardableResult
    func setAction(closure: @escaping closureTapGestureAlias) -> Self {
        self.action = closure
        return self
    }
    
    @discardableResult
    func setStateGesture(_ states: [UIGestureRecognizer.State]) -> Self {
        _ = self.onTapGesture?.setStates(states)
        return self
    }
    
    @discardableResult
    func setTouchPositionRelative(to relative: TapGesture.GestureRelativeTo) -> Self {
        self.gestureRelative = relative
        return self
    }
    
    
//  MARK: - Private Functions Area
    
    private func setDefaultValues() {
        _ = setStateGesture([TapGestureDefault.state])
    }
    
    private func configUserInteractionComponent() {
        self.component?.isUserInteractionEnabled = true
    }
    
    private func createOnTapGesture() {
        self.onTapGesture = OnTapGesture(target: self, action: #selector(tapped))
            .setAction(closure: getOnTapGesture)
            .setStates(self.states)
        
        self.onTapGesture?.cancelsTouchesInView = false
        
        if let onTapGesture = self.onTapGesture {
            self.component?.addGestureRecognizer(onTapGesture)
        }
    }
    
    private func getOnTapGesture(_ onTapGesture: OnTapGesture) {
        if let action = self.action {
            action(self)
        }
    }
    
    
//  MARK: - Objc Function Area
    @objc func tapped(sender: UITapGestureRecognizer) {}
}



//  MARK: - ONTAPGESTURE CLASS ---

fileprivate class OnTapGesture: UITapGestureRecognizer {
    
    typealias onTapGestureCompletionAlias = (_ onTapGesture: OnTapGesture) -> Void
    
    private var action: onTapGestureCompletionAlias?
    private var _touchPositionSuperView: CGPoint?
    private var _touchPositionWindow: CGPoint?
    private var states: [UIGestureRecognizer.State] = []

    
//  MARK: - GET Functions
    var getState: UIGestureRecognizer.State {self.state}
    var touchPositionSuperView: CGPoint { return self._touchPositionSuperView ?? CGPoint()}
    var touchPositionWindow: CGPoint { return self._touchPositionWindow ?? CGPoint()}
    

//  MARK: - Set Action
    func setAction(closure: @escaping onTapGestureCompletionAlias) -> Self {
        self.action = closure
        return self
    }
    
    func setStates(_ states: [UIGestureRecognizer.State]) -> Self {
        self.states = states
        return self
    }
    
    
//  MARK: - Override Functions Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        setTouchPositions(touches)
        self.state = .began
        callAction()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if !self.states.contains(.changed) {return}
        setTouchPositions(touches)
        self.state = .changed
        callAction()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        if !self.states.contains(.ended) {return}
        setTouchPositions(touches)
        self.state = .ended
        callAction()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        if !self.states.contains(.cancelled) {return}
        self._touchPositionSuperView = nil
        self._touchPositionWindow = nil
        self.state = .cancelled
        callAction()
    }
    
    
//  MARK: - Private Function Area
    private func callAction() {
        if let action = self.action {
            action(self)
        }
    }
    
    private func setTouchPositions(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        self._touchPositionSuperView = touch.location(in: self.view?.superview)
        self._touchPositionWindow = touch.location(in: nil)
    }
}

extension List: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

