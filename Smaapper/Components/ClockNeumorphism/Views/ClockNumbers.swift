//
//  ClockNumbers.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


class ClockNumbers: View {
    
    private let weight: CGFloat = 5
    private var neumorphism: Neumorphism?
    
    override init() {
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addElement()
        configConstraints()
    }
    
    
//  MARK: - STACKS
    lazy var stackLeft: Stack = {
        let st = Stack()
            .setAxis(.vertical)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setSpacing(4)
        return st
    }()
    
    lazy var stackMiddle: Stack = {
        let st = Stack()
            .setAxis(.vertical)
//            .setAlignment(.center)
            .setDistribution(.fillProportionally)
        return st
    }()
    
    lazy var stackRight: Stack = {
        let st = Stack()
            .setAxis(.vertical)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setSpacing(4)
        return st
    }()
    
    
//  MARK: - LEFT STROKES
    
    lazy var leftTopStroke: View = {
        return createView(true)
    }()
    
    lazy var leftBottomStroke: View = {
        return createView(true)
    }()
    

    
//  MARK: - MIDDLE STROKE
    lazy var topMiddleStrokeView: View = {
        return createView(false)
    }()
    
    lazy var topMiddleStroke: View = {
        return createView(true)
    }()
    
    lazy var middleStrokeView: View = {
        return createView(false)
    }()
    lazy var middleStroke: View = {
        return createView(true)
    }()
    
    
    lazy var middleBottomView: View = {
        return createView(false)
    }()
    lazy var bottomMiddleStroke: View = {
        return createView(true)
    }()
    
    
    

//  MARK: - RIGHT STROKE
    
    lazy var rightTopStroke: View = {
        return createView(true)
    }()
    
    lazy var rightBottomStroke: View = {
        return createView(true)
    }()
    
    
    
    
//  MARK: - Private Functions Area
    
    private func configNeumorphism(_ lightPosition: Neumorphism.LightPosition = .rightTop) -> Neumorphism {
        return Neumorphism()
            .setReferenceColor(UIColor.HEX("#26292a"))
            .setShape(.flat)
            .setLightPosition(lightPosition)
            .setIntensity(to:.light,percent: 50)
            .setIntensity(to:.dark,percent: 100)
            .setBlur(to:.light, percent: 0)
            .setBlur(to:.dark, percent: 5)
            .setDistance(to:.light, percent: 3)
            .setDistance(to:.dark, percent: 10)
    }
    
    private func addElement() {
        addStackLeft()
        addStackMiddle()
        addStackRight()
    }
    
    private func addStackLeft() {
        stackLeft.add(insideTo: self)
        leftTopStroke.add(insideTo: stackLeft)
        leftBottomStroke.add(insideTo: stackLeft)
    }

    private func addStackMiddle() {
        stackMiddle.add(insideTo: self)
        topMiddleStrokeView.add(insideTo: stackMiddle)
        middleStrokeView.add(insideTo: stackMiddle)
        middleBottomView.add(insideTo: stackMiddle)
        
        topMiddleStroke.add(insideTo: topMiddleStrokeView)
        middleStroke.add(insideTo: middleStrokeView)
        bottomMiddleStroke.add(insideTo: middleBottomView)
    }
    
    private func addStackRight(){
        stackRight.add(insideTo: self)
        rightTopStroke.add(insideTo: stackRight)
        rightBottomStroke.add(insideTo: stackRight)
    }
    
    private func configConstraints() {
        configStackLeftConstraints()
        configStackMiddleConstraints()
        configStackRightConstraints()
        
        configTopStrokeConstraints()
        configMiddleStrockConstraints()
        configBottomStrokeConstraints()

    }
    
    private func configStackLeftConstraints() {
        stackLeft.makeConstraints({ make in
                make
                    .setTop.setBottom.equalToSuperView(1)
                    .setLeading.equalToSuperView
                    .setWidth.equalToConstant(weight)
            })
    }
    
    
    private func configStackMiddleConstraints() {
        stackMiddle.makeConstraints({ make in
                make
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalTo(stackLeft, .trailing, 0)
                    .setTrailing.equalTo(stackRight, .leading, 0)
            })
    }
    
    private func configStackRightConstraints() {
        stackRight.makeConstraints({ make in
                make
                    .setTop.setBottom.equalToSuperView(1)
                    .setTrailing.equalToSuperView
                    .setWidth.equalToConstant(weight)
            })
    }
    
    
    private func configTopStrokeConstraints() {
        topMiddleStroke.makeConstraints { make in
            make
                .setPinTop.equalToSuperView
                .setHeight.equalToConstant(weight/1.4)
        }
    }
    
    private func configMiddleStrockConstraints() {
        middleStroke.makeConstraints { make in
            make
                .setVerticalAlignmentY.equalToSafeArea
                .setLeading.setTrailing.equalToSuperView
                .setHeight.equalToConstant(weight/2)
        }
    }
    
    private func configBottomStrokeConstraints() {
        bottomMiddleStroke.makeConstraints { make in
            make
                .setPinBottom.equalToSuperView
                .setHeight.equalToConstant(weight/1.4)
        }
    }
    
    private func createView(_ withNeumorphism: Bool, _ lightPosition: Neumorphism.LightPosition = .leftTop) -> View {
        let v = View()
        if withNeumorphism {
            configNeumorphism(lightPosition).apply(v)
        }
        return v
    }
    
}
