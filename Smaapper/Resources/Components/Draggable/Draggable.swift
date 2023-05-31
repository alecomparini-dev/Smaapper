//
//  DragDrop.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/05/23.
//

import UIKit


protocol DraggableDelegate: AnyObject {
    func beganDragging(_ draggable: Draggable)
    func dragging(_ draggable: Draggable)
    func dropped(_ draggable: Draggable)
    func draggableCancelled(_ draggable: Draggable)
}


class Draggable: UIPanGestureRecognizer {
    
    enum GestureRelativeTo {
        case window
        case superview
        case component
    }
    
    weak var delegateDraggable: DraggableDelegate?
    
    private var originalPosition: CGPoint = .zero
    private var translation: CGPoint = .zero
    
    private var _velocity: CGPoint = CGPointZero
    private var _translation: CGPoint = CGPointZero
    private var _positionSuperView: CGPoint = CGPointZero
    private var _positionWindow: CGPoint = CGPointZero
    private var _positionComponent: CGPoint = CGPointZero
    
    private weak var component: UIView?
    
    init(_ component: UIView) {
        super.init(target: nil, action: nil)
        self.component = component
        self.initialization()
    }
    
    private func initialization() {
        self.addTarget(self, action: #selector(draggableGesture(_:)))
        self.component?.addGestureRecognizer(self)
    }

    
//  MARK: - GET Properties
    var getVelocity: CGPoint { self._velocity}
    var getTranslation: CGPoint { self._translation}
    
    func getTouchPosition(_ positionRelative: GestureRelativeTo) -> CGPoint {
        switch positionRelative {
            case .window:
                return self._positionWindow
            
            case .superview:
                return self._positionSuperView
            
            case .component:
                return self._positionComponent
        }
    }
    
    
//  MARK: - Private Area
    private func beganDragging() {
        setPoints()
        originalPosition = component?.center ?? .zero
        delegateDraggable?.beganDragging(self)
    }
    
    private func dragging() {
        setPoints()
        let newPosition = CGPoint(x: originalPosition.x + translation.x,
                                  y: originalPosition.y + translation.y)
        component?.center = newPosition
        delegateDraggable?.dragging(self)
    }
    
    private func dropped() {
        setPoints()
        delegateDraggable?.dropped(self)
    }
    
    private func draggableCancelled() {
        setPoints()
        delegateDraggable?.draggableCancelled(self)
    }
    
    private func setPoints() {
        self._positionComponent = self.location(in: self.component)
        self._positionSuperView = self.location(in: self.component?.superview)
        self._positionWindow = self.location(in: nil)
        
        self._velocity = self.velocity(in: self.component)
        self._translation = self.translation(in: self.component)
    }

    
//  MARK: - OBJC Gesture
    @objc
    private func draggableGesture(_ gesture: UIPanGestureRecognizer) {
        self.translation = gesture.translation(in: component)
        
        switch gesture.state {
            case .began:
                self.beganDragging()
            
            case .changed:
                self.dragging()
                
            case .ended:
                self.dropped()
            
            case .cancelled:
                self.draggableCancelled()
            
            default:
                break
        }
    }

    
}
