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
        case component
    }
    
    var tapGestureDelegate: TapGestureDelegate?
    
    private var _touchPositionComponent: CGPoint = CGPointZero
    private var _touchPositionSuperView: CGPoint = CGPointZero
    private var _touchPositionWindow: CGPoint = CGPointZero
    
    private weak var component: UIView?
    
    init(_ component: UIView) {
        super.init(target: nil, action: nil)
        self.component = component
        self.initialization()
    }
    
    private func initialization() {
        self.addTarget(self, action: #selector(objcTapGesture(_:)))
        self.component?.addGestureRecognizer(self)
    }
    
    
//  MARK: - GET Properties
        
    var getState: UITapGestureRecognizer.State { self.state }
    
    func getTouchPosition(_ touchPositionRelative: GestureRelativeTo) -> CGPoint {
        switch touchPositionRelative {
            case .window:
                return self._touchPositionWindow
            
            case .superview:
                return self._touchPositionSuperView
            
            case .component:
                return self._touchPositionComponent
        }
    }
    
    
//  MARK: - OBJC Gesture
    @objc
    private func objcTapGesture(_ gesture: UITapGestureRecognizer) {
        switch gesture.state {
            case .began:
                self.beganTap()
            
            case .changed:
                self.moved()
                
            case .ended:
                self.endedTap()
            
            case .cancelled:
                self.tapCancelled()
            
            default:
                break
        }
    }
    
    
//  MARK: - PRIVATE Area
    private func beganTap() {
        setTouchPositions()
        tapGestureDelegate?.touchBegan(self)
    }

    private func endedTap() {
        setTouchPositions()
        tapGestureDelegate?.touchEnded(self)
    }
    
    private func moved() {
        setTouchPositions()
        tapGestureDelegate?.touchMoved(self)
    }

    private func tapCancelled() {
        tapGestureDelegate?.touchCancelled(self)
    }

        
    private func setTouchPositions() {
        self._touchPositionComponent = self.location(in: self.component)
        self._touchPositionSuperView = self.location(in: self.component?.superview)
        self._touchPositionWindow = self.location(in: nil)
    }
    
    


    
}
