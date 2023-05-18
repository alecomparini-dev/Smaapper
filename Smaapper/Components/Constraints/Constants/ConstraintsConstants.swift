//
//  ConstraintsConstant.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//


import UIKit

enum ConstraintsRelations {
    case equalTo
    case lessThanOrEqualTo
    case greaterThanOrEqualTo
    
    func toNSLayoutConstraintRelation() -> NSLayoutConstraint.Relation {
        switch self {
        case .equalTo:
            return .equal
        case .lessThanOrEqualTo:
            return .lessThanOrEqual
        case .greaterThanOrEqualTo:
            return .greaterThanOrEqual
        }
    }
    
}

enum ConstraintsTypeElement {
    case element
    case safeArea
    case superView
}

enum ConstraintsAttribute {
    case top
    case bottom
    case leading
    case trailing
    case height
    case width
    case horizontalX
    case verticalY
    case notAnAttribute

    func toNSLayoutConstraintAttribute() -> NSLayoutConstraint.Attribute {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        case .height:
            return .height
        case .width:
            return .width
        case .horizontalX:
            return .centerX
        case .verticalY:
            return .centerY
        case .notAnAttribute:
            return .notAnAttribute
        }
    }
}


protocol ConstraintsAttributeProtocol {
    func toConstraintsAttribute() -> ConstraintsAttribute
}

enum ConstraintsNotAnAttribute {
    case notAnAttribute
    
    func toConstraintsAttribute() -> ConstraintsAttribute {
        switch self {
        case .notAnAttribute:
            return .notAnAttribute
        }
    }
}

enum ConstraintsPositionX: ConstraintsAttributeProtocol{
    case leading
    case trailing
    
    func toConstraintsAttribute() -> ConstraintsAttribute {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

enum ConstraintsPositionY: ConstraintsAttributeProtocol {
    case top
    case bottom
    
    func toConstraintsAttribute() -> ConstraintsAttribute {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        }
    }
}

enum ConstraintsAlignment: ConstraintsAttributeProtocol {
    case horizontalX
    case verticalY
    
    func toConstraintsAttribute() -> ConstraintsAttribute {
        switch self {
        case .horizontalX:
            return .horizontalX
        case .verticalY:
            return .verticalY
        }
    }
}

enum ConstraintsSize: ConstraintsAttributeProtocol{
    case height
    case width
    
    func toConstraintsAttribute() -> ConstraintsAttribute {
        switch self {
        case .height:
            return .height
        case .width:
            return .width
        }
    }
}

