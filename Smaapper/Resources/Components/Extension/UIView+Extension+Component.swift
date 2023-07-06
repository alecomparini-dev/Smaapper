//
//  UIView+Extension+Component.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 11/04/23.
//

import UIKit

extension UIView {
    
    func add(insideTo element: UIView) {
        if element.isKind(of: UIStackView.self) {
            let element = element as! UIStackView
            element.addArrangedSubview(self)
            return
        }
        element.addSubview(self)
    }
    
    @discardableResult
    public func setBackgroundColor(_ color: UIColor) -> Self {
        if countShadows() > 0 {
            setBackgroundColorLayer(color)
            return self
        }
        self.backgroundColor = color
        return self
    }
    
   
    @discardableResult
    func setUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = interactionEnabled
        return self
    }
   
    func replicateFormat( width: CGFloat? = nil, height: CGFloat? = nil, cornerRadius: CGFloat? = nil ) -> UIBezierPath {
        let replicateWidth = width ?? self.frame.width
        let replicateHeight = height ?? self.frame.height
        let replicateCornerRadius = cornerRadius ?? self.layer.cornerRadius
        
        return UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0),
                                                size: CGSize(width: replicateWidth,
                                                             height: replicateHeight)),
                            byRoundingCorners: self.layer.maskedCorners.toRectCorner ,
                            cornerRadii: CGSize(width: replicateCornerRadius, height: replicateCornerRadius))
    }
    
    

//  MARK: - SET
    @discardableResult
    func makeConstraints(_ buildConstraintFlow: (_ make: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        _ = buildConstraintFlow(StartOfConstraintsFlow(self))
        return self
    }
    
    @discardableResult
    func makeBorder(_ border: (_ make: BorderBuilder) -> BorderBuilder) -> Self {
        _ = border(BorderBuilder(self))
        return self
    }
    
    @discardableResult
    func makeShadow(_ shadow: (_ make: ShadowBuilder) -> ShadowBuilder) -> Self {
        _ = shadow(ShadowBuilder(self))
        return self
    }
    
    @discardableResult
    func makeNeumorphism(_ neumorphism: (_ make: NeumorphismBuilder) -> NeumorphismBuilder) -> Self {
        _ = neumorphism(NeumorphismBuilder(self))
        return self
    }
    
    @discardableResult
    func makeGradient(_ gradient: (_ make: GradientBuilder) -> GradientBuilder) -> Self {
        _ = gradient(GradientBuilder(self))
        return self
    }
    
    @discardableResult
    func makeBlur(_ blur: (_ make: BlurBuilder) -> BlurBuilder) -> Self {
        _ = blur(BlurBuilder(self))
        return self
    }
    
    @discardableResult
    func makeTapGesture(_ tapGesture: (_ make: TapGestureBuilder) -> TapGestureBuilder) -> Self {
        _ = tapGesture(TapGestureBuilder(self))
        return self
    }
    
    
//  MARK: - hideKeyboardWhenViewTapped
    
    func hideKeyboardWhenViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }

    
//  MARK: - PRIVATE Area
    private func setBackgroundColorLayer(_ color: UIColor) {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.cornerRadius = self.layer.cornerRadius
        layer.maskedCorners = self.layer.maskedCorners
        layer.fillColor = color.cgColor
        layer.backgroundColor = color.cgColor
        let position = UInt32(countShadows())
        self.layer.insertSublayer(layer, at: position )
    }
    
    private func countShadows() -> Int {
        return self.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0
    }

    
    
}

