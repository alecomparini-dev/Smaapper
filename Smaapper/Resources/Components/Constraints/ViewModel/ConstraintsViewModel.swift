//
//  ConstraintsViewModel.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 19/04/23.
//

import UIKit

class ConstraintsViewModel {
    
    private var model: ConstraintsModel
    
    init() {
        self.model = ConstraintsModel()
    }

    var getConstraint: ConstraintsModel {
        return model
    }

    var mainElement: UIView {
        get { model.mainElement }
        set { model.mainElement = newValue}
    }
    
    var mainAttribute: [ConstraintsAttribute] { model.mainAttribute }
    
    func mainAttribute(_ value: ConstraintsAttribute) {
        model.mainAttribute.append(value)
    }
    
    var typeElement: ConstraintsTypeElement { model.typeElement }
    
    var relation: ConstraintsRelations { model.relation }
    
    
    
    func equalTo(_ element: UIView, _ attribute: ConstraintsAttribute? = nil, _ constant: CGFloat? = nil) {
        updateRelations(.equalTo, element, attribute, constant)
    }
    func equalTo(_ element: UIView, _ constant: CGFloat? = nil) {
        updateRelations(.equalTo, element, nil, constant)
    }
    
    func greaterThanOrEqualTo(_ element: UIView, _ attribute: ConstraintsAttribute? = nil, _ constant: CGFloat? = nil) {
        updateRelations(.greaterThanOrEqualTo, element, attribute, constant)
    }
    
    func lessThanOrEqualTo(_ element: UIView, _ attribute: ConstraintsAttribute? = nil, _ constant: CGFloat? = nil) {
        updateRelations(.lessThanOrEqualTo, element, attribute, constant)
    }
    

    
//  MARK: - SAFE AREA
    func equalToSafeArea(_ constant: CGFloat = 0) {
        model.typeElement = .safeArea
        updateRelations(.equalTo, constant)
    }
    
    func lessThanOrEqualToSafearea(_ constant: CGFloat = 0) {
        model.typeElement = .safeArea
        updateRelations(.lessThanOrEqualTo, constant)
    }
    
    func greaterThanOrEqualToSafearea(_ constant: CGFloat = 0) {
        model.typeElement = .safeArea
        updateRelations(.greaterThanOrEqualTo, constant)
    }
    
    

//  MARK: - SUPERVIEW
    func equalToSuperView(_ constant: CGFloat = 0) {
        model.typeElement = .superView
        updateRelations(.equalTo, constant)
    }
    
    func lessThanOrEqualToSuperView(_ constant: CGFloat = 0) {
        model.typeElement = .superView
        updateRelations(.lessThanOrEqualTo, constant)
    }
    
    func greaterThanOrEqualToSuperView(_ constant: CGFloat = 0) {
        model.typeElement = .superView
        updateRelations(.greaterThanOrEqualTo, constant)
    }
    
    
//  MARK: - Constant
    func equalToConstant(_ constant: CGFloat) {
        updateRelations(.equalTo, constant)
    }
    func lessThanOrEqualToConstant(_ constant: CGFloat) {
        updateRelations(.lessThanOrEqualTo, constant)
    }
    func greaterThanOrEqualToConstant(_ constant: CGFloat) {
        updateRelations(.greaterThanOrEqualTo, constant)
    }
    
    var toItem: UIView? {
        get { model.toItem }
        set { model.toItem = newValue}
    }
    
    var toAttribute: ConstraintsAttribute? {
        get { model.toAttribute }
        set { model.toAttribute = newValue}
    }
    
    var constant: CGFloat? {
        get { model.constant }
        set { model.constant = newValue ?? 0}
    }
    
    var multiplier: CGFloat{
        get { model.multiplier }
        set { model.multiplier = newValue}
    }

    func startModel() {
        self.model = ConstraintsModel()
    }
    
    
    private func updateRelations(_ relation: ConstraintsRelations, _ toItem: UIView? = nil, _ attribute: ConstraintsAttribute? = nil, _ constant: CGFloat? = nil) {
        model.relation = relation
        self.toItem = toItem
        self.toAttribute = attribute
        self.constant = constant ?? 0
    }
    
    private func updateRelations(_ relation: ConstraintsRelations, _ constant: CGFloat) {
        self.updateRelations(relation, nil, nil, constant )
    }
    
}
