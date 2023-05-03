//
//  Neumorphism.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/05/23.
//

import UIKit

class Neumorphism {
    
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
    
    
    private let ratioOfSize = 0.08
    private let lightShadeColorPercentage = 1.61
    private let darkShadeColorPercentage = 0.42
    private let component: UIView
    private var referenceColor: UIColor?
    private var _lightShadeColor: UIColor?
    private var _darkShadeColor: UIColor?
    private var distance: CGFloat?
    private var blur: CGFloat?
    private var intensity: Float = 1
    private var shape: Shape = .flat
    private var lightPosition: LightPosition = .leftTop
    

    init(_ component: UIView) {
        self.component = component
    }
    
    
//  MARK: - GET Properties
    var darkShadeColor: UIColor {self._darkShadeColor ?? UIColor() }
    var lightShadeColor: UIColor { self._lightShadeColor ?? UIColor() }
    
    
//  MARK: - SET Properties
    
    func setReferenceColor(_ color: UIColor) -> Self {
        self.referenceColor = color
        return self
    }

    func setDistance(percent distance: CGFloat) -> Self {
        let maxDistance = 50.0
        if !(0.0...100.0).contains(distance) {
            print("Allowed values for distance 0.0...100.0. Default 10")
            return self
        }
        self.distance = max(distance * maxDistance / 100, 5.0)
        return self
    }
    
    func setBlur(percent blur: CGFloat) -> Self {
        let maxBlur = 50.0
        if !(0.0...100.0).contains(distance ?? 10) {
            print("Allowed values for blur 0.0...100.0%. Default 10")
            return self
        }
        self.blur = blur * maxBlur / 100
        return self
    }

    func setIntensity(percent intensity: Float) -> Self {
        if !(0.0...100.0).contains(intensity) {
            print("Allowed values for intensity 0.0...100.0%. Default 1")
            return self
        }
        self.intensity = intensity / 100
        return self
    }
    
    func setShape(_ shape: Shape) -> Self {
        self.shape = shape
        return self
    }
    
    func setLightPosition(_ lightPosition: LightPosition) -> Self {
        self.lightPosition = lightPosition
        return self
    }
    
    func setLightShadeColor(_ color: UIColor) -> Self {
        self._lightShadeColor = color
        return self
    }
    
    func setDarkShadeColor(_ color: UIColor) -> Self {
        self._darkShadeColor = color
        return self
    }
    

//  MARK: - APPLY Neumorphis
    
    func apply() -> Self {
        DispatchQueue.main.async {
            self.calculateShadeColorByColorReference()
            self.applyShadow()
            self.applyShape()
        }
        return self
    }
    
    private func applyShadow() {
        let (offSetDarkShadow, offSetLightShadow) = self.calculateLightPosition()
        self.applyLightShadow(offSetLightShadow)
        self.applyDarkShadow(offSetDarkShadow)
        
    }
    
//  MARK: - Private Function Area
    
    private func calculateLightPosition() -> (CGSize, CGSize) {
        let distance = calculateDistance()
        
        switch self.lightPosition {
            case .leftTop:
                return (CGSize(width: distance, height: distance), CGSize(width: -distance, height: -distance))
            
            case .leftBottom:
                return (CGSize(width: distance, height: -distance), CGSize(width: -distance, height: distance))
            
            case .rightTop:
                return (CGSize(width: -distance, height: distance), CGSize(width: distance, height: -distance))
            
            case .rightBottom:
                return (CGSize(width: -distance, height: -distance), CGSize(width: distance, height: distance))
        }
    }
    
    
    
//  MARK: - SHADOW AREA
    
    private func applyDarkShadow(_ offSetDarkShadow: CGSize) {
        _ = self.component
            .setShadow { build in
                build.setColor(self.darkShadeColor)
                    .setOffset(offSetDarkShadow)
                    .setOpacity(self.intensity)
                    .setRadius(self.calculateBlur())
                    .apply()
            }
    }
    
    private func applyLightShadow(_ offSetLightShadow: CGSize) {
        _ = self.component
            .setShadow { build in
                build.setColor(self.lightShadeColor)
                    .setOffset(offSetLightShadow)
                    .setOpacity(self.intensity)
                    .setRadius(self.calculateBlur())
                    .apply()
            }
    }
    
    private func calculateShadeColorByColorReference() {
        calculateLightShade()
        calculateDarkShade()
        
    }
    
    private func calculateDarkShade() {
        if self._darkShadeColor != nil { return }
        guard let referenceColor = self.referenceColor else {return }
        _ = self.setDarkShadeColor(referenceColor.getBrightness(self.darkShadeColorPercentage))
    }

    private func calculateLightShade() {
        if self._lightShadeColor != nil { return }
        guard let referenceColor = self.referenceColor else {return }
        _ = self.setLightShadeColor(referenceColor.getBrightness(self.lightShadeColorPercentage))

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
        let dark = self.referenceColor!.getBrightness(0.80)
        let light = self.referenceColor!.getBrightness(1.25)
        return (dark,light)
    }
    
    private func addShapeOnComponent(_ color: [UIColor]) {
        _ = self.component
            .setGradient { build in
                build.setColor(color)
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
    
    private func setShapeFlat() {
        _ = component.setBackgroundColorLayer(self.referenceColor ?? UIColor())
    }
    
    private func setShapeConcave() {
        let (dark,light) = getShapeColorByColorReference()
        self.addShapeOnComponent([dark,light])
    }
    
    private func setShapeConvex() {
        let (dark,light) = getShapeColorByColorReference()
        self.addShapeOnComponent([light,dark])
    }
    
    
//  MARK: - Calculate Blur and Distance
    
    private func calculateDistance() -> CGFloat {
        return self.distance ?? (self.component.frame.width * ratioOfSize)
    }
    
    private func calculateBlur() -> CGFloat {
        return self.blur ?? (self.component.frame.width * ratioOfSize)
    }
    
}


extension UIColor {
    func getBrightness(_ percentage: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        let newBrightness = brightness * percentage
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    
}

