//
//  Neumorphism.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/05/23.
//

import UIKit

class Neumorphism {
    
    enum Shadow {
        case light
        case dark
    }
    
    enum Shape {
        case flat
        case concave
        case convex
        case pressed
        case none
    }
    
    enum LightPosition {
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    
    private let lightShadeColorPercentage: CGFloat = 60
    private let darkShadeColorPercentage: CGFloat = -85
    private let lightShapeColorByColorReferencePercentage: CGFloat = 70
    private let darkShapeColorByColorReferencePercentage: CGFloat = -30

    
    private var component: UIView
    private var referenceColor: UIColor?
    private var lightShadowColor: UIColor?
    private var darkShadowColor: UIColor?
    private var darkShadowDistance: CGFloat = 0
    private var lightShadowDistance: CGFloat = 0
    private var lightShadowBlur: CGFloat = 0
    private var darkShadowBlur: CGFloat = 0
    private var lightShadowIntensity: Float = 0
    private var darkShadowIntensity: Float = 0
    private var shape: Shape = .flat
    private var lightPosition: LightPosition = .leftTop
    

    init(_ component: UIView = UIView()) {
        self.component = component
        self.initialization()
    }
    
    private func initialization() {
        setBlur(percent: 10)
            .setDistance(percent: 10)
            .setIntensity(percent: 100)
    }
   
    
//  MARK: - SET Properties

    @discardableResult
    func setReferenceColor(_ color: UIColor) -> Self {
        self.referenceColor = color
        return self
    }

    @discardableResult
    func setShadowColor(to shadow: Neumorphism.Shadow, _ color: UIColor) -> Self {
        switch shadow {
            case .light:
                self.lightShadowColor = color
            case .dark:
                self.darkShadowColor = color
        }
        return self
    }

    @discardableResult
    func setShadowColor(_ color: UIColor) -> Self {
        self.lightShadowColor = color
        self.darkShadowColor = color
        return self
    }

    @discardableResult
    func setDistance(percent distance: CGFloat) -> Self {
        if !validatePercent("distance", distance, 10) {
            return self
        }
        let distance = calculateRatioPercent(50, distance)
        self.lightShadowDistance = distance
        self.darkShadowDistance = distance
        return self
    }

    @discardableResult
    func setDistance(to: Neumorphism.Shadow, percent distance: CGFloat) -> Self {
        if !validatePercent("distance", distance, 10) {
            return self
        }
        let percentDistance = calculateRatioPercent(50, distance)
        switch to {
            case .light:
                self.lightShadowDistance = percentDistance
            case .dark:
                self.darkShadowDistance = percentDistance
        }
        return self
    }

    @discardableResult
    func setBlur(percent blur: CGFloat) -> Self {
        if !validatePercent("blur", blur, 10) {
            return self
        }
        let percentBlur = calculateRatioPercent(50, blur)
        self.lightShadowBlur = percentBlur
        self.darkShadowBlur = percentBlur
        return self
    }
    
    @discardableResult
    func setBlur(to: Neumorphism.Shadow, percent blur: CGFloat) -> Self {
        if !validatePercent("blur", blur, 10) {
            return self
        }
        let percentBlur = calculateRatioPercent(50, blur)
        switch to {
            case .light:
                self.lightShadowBlur = percentBlur
            case .dark:
                self.darkShadowBlur = percentBlur
        }
        return self
    }
    
    @discardableResult
    func setIntensity(percent intensity: CGFloat) -> Self {
        if !validatePercent("intensity", intensity, 100) {
            return self
        }
        let percentIntensity =  Float(calculateRatioPercent(100, intensity)) / 100
        self.darkShadowIntensity = percentIntensity
        self.lightShadowIntensity = percentIntensity
        return self
    }

    @discardableResult
    func setIntensity(to: Neumorphism.Shadow, percent intensity: CGFloat) -> Self {
        if !validatePercent("intensity", intensity, 100) {
            return self
        }
        let percentIntensity = Float(calculateRatioPercent(100, intensity)) / 100
        switch to {
        case .light:
            self.lightShadowIntensity = percentIntensity
        case .dark:
            self.darkShadowIntensity = percentIntensity
        }
        return self
    }
    
    @discardableResult
    func setShape(_ shape: Shape) -> Self {
        self.shape = shape
        return self
    }

    @discardableResult
    func setLightPosition(_ lightPosition: LightPosition) -> Self {
        self.lightPosition = lightPosition
        return self
    }
    
    
//  MARK: - APPLY Neumorphis
    @discardableResult
    func apply() -> Self {
        self.calculateShadeColorByColorReference()
//        DispatchQueue.main.async {
            self.applyShadow()
            self.applyShape()
//        }
        return self
    }
    
    
    private func applyShadow() {
        let (offSetDarkShadow, offSetLightShadow) = self.calculateLightPosition()
        self.applyDarkShadow(offSetDarkShadow)
        self.applyLightShadow(offSetLightShadow)
        
    }
    
//  MARK: - Private Function Area
    private func validatePercent(_ property: String , _ percent: CGFloat, _ defaultPercent: CGFloat ) -> Bool {
        if !ValidatePercent.validate(percent) {
            print("Allowed values for \(property) 0.0...100.0%. Default \(defaultPercent)%")
            return false
        }
        return true
    }
    
    private func calculateRatioPercent(_ max: CGFloat, _ percent: CGFloat) -> CGFloat {
        return (percent * max) / 100
    }
    
    private func calculateLightPosition() -> (CGSize, CGSize) {
        let darkDistance = self.darkShadowDistance
        let lightDistance = self.lightShadowDistance
        
        switch self.lightPosition {
            case .leftTop:
                let darkOffset = CGSize(width: darkDistance, height: darkDistance)
                let lightOffset = CGSize(width: -lightDistance, height: -lightDistance)
                return (darkOffset, lightOffset)
            
            case .leftBottom:
                let darkOffset = CGSize(width: darkDistance, height: -darkDistance)
                let lightOffset = CGSize(width: -lightDistance, height: lightDistance)
                return (darkOffset, lightOffset)
            
            case .rightTop:
                let darkOffset = CGSize(width: -darkDistance, height: darkDistance)
                let lightOffset = CGSize(width: lightDistance, height: -lightDistance)
                return (darkOffset, lightOffset)
            
            case .rightBottom:
                let darkOffset = CGSize(width: -darkDistance, height: -darkDistance)
                let lightOffset = CGSize(width: lightDistance, height: lightDistance)
                return (darkOffset, lightOffset)
        }
    }
    
    
//  MARK: - SHADOW AREA
    
    private func applyDarkShadow(_ offSetDarkShadow: CGSize) {
        self.component
            .makeShadow { build in
                build.setColor(self.darkShadowColor ?? .clear)
                    .setOffset(offSetDarkShadow)
                    .setOpacity(self.darkShadowIntensity)
                    .setRadius(self.darkShadowBlur)
                    .apply()
            }
    }
    
    private func applyLightShadow(_ offSetLightShadow: CGSize) {
        self.component
            .makeShadow { build in
                build.setColor(self.lightShadowColor ?? .clear)
                    .setOffset(offSetLightShadow)
                    .setOpacity(self.lightShadowIntensity)
                    .setRadius(self.lightShadowBlur)
                    .apply()
            }
    }
    
    private func calculateShadeColorByColorReference() {
        calculateLightShade()
        calculateDarkShade()
    }
    
    private func calculateDarkShade() {
        if self.darkShadowColor != nil { return }
        guard let referenceColor = self.referenceColor else {return }
        self.setShadowColor(to: .dark, referenceColor.adjustBrightness(self.darkShadeColorPercentage))
    }

    private func calculateLightShade() {
        if self.lightShadowColor != nil { return }
        guard let referenceColor = self.referenceColor else {return }
        self.setShadowColor(to: .light, referenceColor.adjustBrightness(self.lightShadeColorPercentage))

    }


//  MARK: - SHAPE AREA
    
    private func applyShape() {
        switch self.shape {
            case .flat:
                setShapeFlat()
                return
            case .concave:
                setShapeConcave()
                return
            case .convex:
                setShapeConvex()
                return
            case .pressed:
                return
            case .none:
                return
        }
    }
    
    private func getShapeColorByColorReference() -> (UIColor,UIColor) {
        let dark = self.referenceColor!.adjustBrightness(darkShapeColorByColorReferencePercentage)
        let light = self.referenceColor!.adjustBrightness(lightShapeColorByColorReferencePercentage)
        return (dark,light)
    }
    
    private func addShapeOnComponent(_ color: [UIColor]) {
        self.component
            .makeGradient { build in
                build
                    .setGradientColors(color)
                    .setAxialGradient(self.calculateGradientDirection())
                    .apply()
            }
    }
    
    private func calculateGradientDirection() -> Gradient.Direction {
        switch lightPosition {
            case .leftTop:
                return .leftTopToRightBottom
            case .leftBottom:
                return .leftBottomToRightTop
            case .rightTop:
                return .rightTopToLeftBottom
            case .rightBottom:
                return .rightBottomToLeftTop
        }
    }
    
    
    private func setShapeConcave() {
        let (dark,light) = getShapeColorByColorReference()
        self.addShapeOnComponent([dark,light])
    }
    
    private func setShapeConvex() {
        let (dark,light) = getShapeColorByColorReference()
        self.addShapeOnComponent([light,dark])
    }
    
    private func setShapeFlat() {
        if let referenceColor {
            self.addShapeOnComponent([referenceColor, referenceColor])
        }
    }
    
}


