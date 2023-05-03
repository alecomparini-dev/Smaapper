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
    
    private enum ShadeColor {
        case light
        case dark
    }
    
    private let ratioOfSize = 0.08
    private let lightShadeColorPercentage = 1.61
    private let darkShadeColorPercentage = 0.42
    private let component: UIView
    private var referenceColor: UIColor?
    private var lightShadeColor: UIColor?
    private var darkShadeColor: UIColor?
    private var distance: CGFloat?
    private var blur: CGFloat?
    private var intensity: Float = 1
    private var shape: Shape = .flat
    private var lightPosition: LightPosition = .leftTop

    
    init(_ component: UIView) {
        self.component = component
    }
    
    
//  MARK: - Set Properties
    
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
        self.lightShadeColor = color
        return self
    }
    
    func setDarkShadeColor(_ color: UIColor) -> Self {
        self.darkShadeColor = color
        return self
    }
    
    
    func apply() -> Self {
        DispatchQueue.main.async {
            let (lightColor, darkColor) = self.calculateShadeColor()
            let (offSetDarkShadow, offSetLightShadow) = self.calculateLightPosition()
            self.applyShape()
            self.applyDarkShadow(darkColor, offSetDarkShadow)
            self.applyLightShadow(lightColor, offSetLightShadow)
        }
        
        return self
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
    
    
    private func calculateDistance() -> CGFloat {
        return self.distance ?? (self.component.frame.width * ratioOfSize)
    }
    
    private func calculateBlur() -> CGFloat {
        return self.blur ?? (self.component.frame.width * ratioOfSize)
    }

    
    private func calculateShadeColor() -> (UIColor, UIColor) {
        let lightColor = getLightShadeColor()
        let darkColor = getDarkShadeColor()
        return (lightColor, darkColor)
    }
    
    private func getLightShadeColor() -> UIColor {
        if let lightShadeColor = self.lightShadeColor {
            return lightShadeColor
        }
        return getShadeColorByColorReference(.light)
    }
    
    private func getDarkShadeColor() -> UIColor {
        if let darkShadeColor = self.darkShadeColor {
            return darkShadeColor
        }
        return getShadeColorByColorReference(.dark)
    }
    
    private func getShadeColorByColorReference(_ shadeColor: ShadeColor) -> UIColor {
        guard let referenceColor = self.referenceColor else {return UIColor()}
        switch shadeColor {
            case .light:
                return referenceColor.getBrightness(self.lightShadeColorPercentage)
            case .dark:
                return referenceColor.getBrightness(self.darkShadeColorPercentage)
        }
    }
    
    private func applyDarkShadow(_ darkColor: UIColor, _ offSetDarkShadow: CGSize) {
        _ = self.component
            .setShadow { build in
                build.setColor(darkColor)
                    .setOffset(offSetDarkShadow)
                    .setOpacity(self.intensity)
                    .setRadius(self.calculateBlur())
                    .apply()
            }
    }
    
    private func applyLightShadow(_ lightColor: UIColor, _ offSetLightShadow: CGSize) {
        _ = self.component
            .setShadow { build in
                build.setColor(lightColor)
                    .setOffset(offSetLightShadow)
                    .setOpacity(self.intensity)
                    .setRadius(self.calculateBlur())
                    .apply()
            }
    }
    
    private func applyShape() {
        switch self.shape {
          
        case .flat:
            _ = component.setBackgroundColorLayer(self.referenceColor ?? UIColor())
            return
        case .concave:
            return
        case .convex:
            return
        case .pressed:
            return
        case .none:
            return
        }
        
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

