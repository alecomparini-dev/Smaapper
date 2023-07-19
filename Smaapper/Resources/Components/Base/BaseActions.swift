//
//  BaseActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit


class BaseActions {
    typealias touchBaseActionAlias = (_ component: UIView, _ tapGesture: TapGesture?) -> Void
    
    private var baseBuilder: BaseBuilder
    private(set) var tapGesture: TapGestureBuilder?
    private(set) var draggable: DraggableBuilder?

    init(_ baseBuilder: BaseBuilder) {
        self.baseBuilder = baseBuilder
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setTouch(_ closure: @escaping touchBaseActionAlias, _ cancelsTouchesInView: Bool = true) -> Self {
        self.setTapGesture { build in
            build
                .setCancelsTouchesInView(cancelsTouchesInView)
                .setTouchEnded { [weak self] tapGesture in
                    guard let self else {return}
                    closure(self.baseBuilder.component, tapGesture)
                }
        }
        return self
    }
    
    @discardableResult
    func setTapGesture(_ build: (_ build: TapGestureBuilder) -> TapGestureBuilder) -> Self {
        if let tapGesture = self.tapGesture {
            self.tapGesture = build(tapGesture)
            return self
        }
        self.tapGesture = build(TapGestureBuilder(baseBuilder.component))
        return self
    }
    
    @discardableResult
    func setDraggable(_ build: (_ build: DraggableBuilder) -> DraggableBuilder) -> Self {
        self.draggable = build(DraggableBuilder(baseBuilder.component))
        return self
    }
    
    @discardableResult
    func setDraggable() -> Self {
        self.draggable = DraggableBuilder(baseBuilder.component)
        return self
    }
    
}
