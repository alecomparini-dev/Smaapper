//
//  DraggableBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/05/23.
//

import UIKit


class DraggableBuilder  {
    
    typealias draggableAlias = (_ draggable: Draggable) -> Void
        
    private var _beganDragging: draggableAlias?
    private var _dragging: draggableAlias?
    private var _dropped: draggableAlias?
    private var _draggableCancelled: draggableAlias?
    
    private var draggable: Draggable
    private weak var component: UIView?
    
    init(_ component: UIView) {
        self.component = component
        self.draggable = Draggable(component)
        self.initialization()
    }
    
    private func initialization() {
        enableUserInteractionComponent()
        configTapGestureDelegate()
    }
    
    private func enableUserInteractionComponent() {
        self.component?.isUserInteractionEnabled = true
    }
    

//  MARK: - Set Properties

    @discardableResult
    func setMaximumNumberOfTouches(_ maxNumberOfTouches: Int) -> Self {
        self.draggable.maximumNumberOfTouches = maxNumberOfTouches
        return self
    }
    
    @discardableResult
    func setMinimumNumberOfTouches(_ minNumberOfTouches: Int) -> Self {
        self.draggable.minimumNumberOfTouches = minNumberOfTouches
        return self
    }
    
    @discardableResult
    func setCancelsTouchesInView(_ cancel: Bool ) -> Self {
        self.draggable.cancelsTouchesInView = cancel
        return self
    }
    
    @discardableResult
    func setBeganDragging(_ closure: (@escaping draggableAlias)) -> Self {
        self._beganDragging = closure
        return self
    }
    
    @discardableResult
    func setDragging(_ closure: (@escaping draggableAlias)) -> Self {
        self._dragging = closure
        return self
    }
    
    @discardableResult
    func setDropped(_ closure: (@escaping draggableAlias)) -> Self {
        self._dropped = closure
        return self
    }
    
    @discardableResult
    func setDragDropCancelled(_ closure: (@escaping draggableAlias)) -> Self {
        self._draggableCancelled = closure
        return self
    }

    
//  MARK: - PRIVATE Area
    private func configTapGestureDelegate() {
        draggable.delegateDraggable = self
    }
    
}



//  MARK: - EXTENSION DragDrop Delegate

extension DraggableBuilder: DraggableDelegate {
    
    func beganDragging(_ draggable: Draggable) {
        self._beganDragging?(draggable)
    }
    
    func dragging(_ draggable: Draggable) {
        self._dragging?(draggable)
    }
    
    func dropped(_ draggable: Draggable) {
        self._dropped?(draggable)
    }
    
    func draggableCancelled(_ draggable: Draggable) {
        self._draggableCancelled?(draggable)
    }
    
}
