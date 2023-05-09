//
//  TapGesture.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/05/23.
//

import UIKit

class TapGesture {
    typealias closureTapGestureAlias = (_ location: CGPoint?, _ state: UIGestureRecognizer.State) -> Void
    
    enum GestureRelativeTo {
        case superview
        case screen
    }
    
    private var action: closureTapGestureAlias?
    
    private var onTapGesture: OnTapGesture?
    private var state: [UIGestureRecognizer.State] = []
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
        switch relative {
            case .superview:
                return CGPoint()
            case .screen:
                return CGPoint()
        }
    }
    
    func getTouchedComponent() -> UIView {
        return UIView()
    }
    
    func getState() -> UIGestureRecognizer.State {
        return .began
    }
    

//  MARK: - Set Properties

    func setClosure(closure: @escaping closureTapGestureAlias) -> Self {
        self.action = closure
        if let onTapGesture = self.onTapGesture {
            self.component?.addGestureRecognizer(onTapGesture)
        }
        return self
    }
    
    func setStateGesture(_ state: [UIGestureRecognizer.State]) -> Self {
        self.state = state
        return self
    }
    
    func setTouchPositionRelative(to relative: TapGesture.GestureRelativeTo) -> Self {
        self.gestureRelative = relative
        return self
    }
    
    
//  MARK: - Apply TapGesture
    func applyGesture() {
        
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
        
        self.onTapGesture?.cancelsTouchesInView = false
        
    }
    
    
    private func getOnTapGesture(_ onTapGesture: OnTapGesture) {
        print(onTapGesture)
    }
    
    
//  MARK: - Objc Function Area
    @objc func tapped(sender: UITapGestureRecognizer) {}
}



//  MARK: - ONTAPGESTURE CLASS ---------------------------------------------------------------------------------------

fileprivate class OnTapGesture: UIGestureRecognizer {
    
    typealias onTapGestureCompletionAlias = (_ onTapGesture: OnTapGesture) -> Void
    
    private var action: onTapGestureCompletionAlias?
    var touchPositionScreen: CGPoint?
    var touchPositionSuperView: CGPoint?
    var getState: UIGestureRecognizer.State? {return self.state}
    

//  MARK: - Set Action
    func setAction(closure: @escaping onTapGestureCompletionAlias) -> Self {
        self.action = closure
        return self
    }
    
    
//  MARK: - Override Functions Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else { return }
        self.touchPositionSuperView = touch.location(in: self.view?.superview)
        self.touchPositionScreen = touch.location(in: nil)
        self.state = .began
        callAction()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else { return }
        self.touchPositionScreen = touch.location(in: self.view?.window)
        self.state = .changed
        callAction()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else { return }
        self.touchPositionScreen = touch.location(in: self.view?.window)
        self.state = .ended
        callAction()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        self.touchPositionScreen = nil
        self.state = .cancelled
        callAction()
    }
    
    
    
    
//  MARK: - Private Function Area
    private func callAction() {
        if let action = self.action {
            action(self)
        }
    }
}

extension List: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

