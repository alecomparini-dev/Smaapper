//
//  TapGesture_.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit

protocol TapGestureDelegate: AnyObject {
    func touchBegan(_ tapGesture: TapGesture)
    func touchMoved(_ tapGesture: TapGesture)
    func touchEnded(_ tapGesture: TapGesture)
    func touchCancelled(_ tapGesture: TapGesture)
}


class TapGesture: UITapGestureRecognizer {
    
    enum GestureRelativeTo {
        case window
        case superview
    }
    
    var tapGestureDelegate: TapGestureDelegate?
    
    private var _touchPositionSuperView: CGPoint?
    private var _touchPositionWindow: CGPoint?
    
    var statesEnabled: [UIGestureRecognizer.State] = []
    
    
//  MARK: - GET Properties
        
    var getState: UIGestureRecognizer.State { self.state }
    
    func getTouchPosition(_ touchPositionRelative: GestureRelativeTo) -> CGPoint {
        switch touchPositionRelative {
            case .window:
                return self._touchPositionWindow ?? CGPoint()
            case .superview:
                return self._touchPositionSuperView ?? CGPoint()
        }
    }
    
    
//  MARK: - Override Functions Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if !statesEnabled.contains(.began) {return}
        setTouchPositions(touches)
        self.state = .began
        tapGestureDelegate?.touchBegan(self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        if !statesEnabled.contains(.ended) {return}
        setTouchPositions(touches)
        self.state = .ended
        tapGestureDelegate?.touchEnded(self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if !statesEnabled.contains(.changed) {return}
        setTouchPositions(touches)
        self.state = .changed
        tapGestureDelegate?.touchMoved(self)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        if !statesEnabled.contains(.cancelled) {return}
        self.state = .cancelled
        tapGestureDelegate?.touchCancelled(self)
    }

    
//  MARK: - Private Function Area
    
    private func setTouchPositions(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        self._touchPositionSuperView = touch.location(in: self.view?.superview)
        self._touchPositionWindow = touch.location(in: nil)
    }
    
}
