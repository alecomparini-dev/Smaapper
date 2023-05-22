//
//  ClockNumbers.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


class ClockNumbers: View {
    
    private var weight: CGFloat = 5
    private var neumorphism: Neumorphism?
    private var number: Int = 0
    
    private let hasLeftTopStroke = [4,5,6,8,9,0]
    private let hasLeftBottomStroke = [2,6,8,0]
    private let hasRightTopStroke = [1,2,3,4,7,8,9,0]
    private let hasRightBottomStroke = [1,3,4,5,6,7,8,9,0]
    private let hasTopMiddleStroke = [2,3,5,7,8,9,0]
    private let hasMiddleStroke = [2,3,4,5,6,8,9]
    private let hasBottomMiddleStroke = [2,3,5,6,8,0]
    
    
    init(number: Int, weight: CGFloat = 5) {
        self.number = number
        self.weight = weight
        super.init()
        self.initialization()
    }
    
    override init() {
        super.init()
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
        return (hasLeftTopStroke.contains(number)) ? createView(true) : View()
    }()
    
    lazy var leftBottomStroke: View = {
        return (hasLeftBottomStroke.contains(number)) ? createView(true) : View()
    }()
    

    
//  MARK: - MIDDLE STROKE
    lazy var topMiddleStrokeView: View = {
        return createView(false)
    }()
    
    lazy var middleStrokeView: View = {
        return createView(false)
    }()
    
    lazy var middleBottomView: View = {
        return createView(false)
    }()
    
    lazy var topMiddleStroke: View = {
        return (hasTopMiddleStroke.contains(number)) ? createView(true) : View()
    }()
    
    lazy var middleStroke: View = {
        return (hasMiddleStroke.contains(number)) ? createView(true) : View()
    }()
    
    lazy var bottomMiddleStroke: View = {
        return (hasBottomMiddleStroke.contains(number)) ? createView(true) : View()
    }()
    

//  MARK: - RIGHT STROKE
    
    lazy var rightTopStroke: View = {
        return (hasRightTopStroke.contains(number)) ? createView(true) : View()
    }()
    
    lazy var rightBottomStroke: View = {
        return (hasRightBottomStroke.contains(number)) ? createView(true) : View()
    }()
    
    
//  MARK: - Private Functions Area
    
    private func configNeumorphism(_ lightPosition: Neumorphism.LightPosition = .leftTop) -> Neumorphism {
        return Neumorphism()
            .setReferenceColor(UIColor.HEX("#26292a"))
            .setShape(.convex)
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
        
        configTopMiddleStrokeConstraints()
        configMiddleStrokeConstraints()
        configBottomMiddleStrokeConstraints()

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
    
    private func configTopMiddleStrokeConstraints() {
        topMiddleStroke.makeConstraints { make in
            make
                .setTop.equalToSuperView
                .setLeading.equalToSuperView
                .setTrailing.equalToSuperView
                .setHeight.equalToConstant(weight/1.4)
        }
    }
    
    private func configMiddleStrokeConstraints() {
        middleStroke.makeConstraints { make in
            make
                .setVerticalAlignmentY.equalToSafeArea
                .setLeading.equalToSuperView
                .setTrailing.equalToSuperView
                .setHeight.equalToConstant(weight/2)
        }
    }
    
    private func configBottomMiddleStrokeConstraints() {
        bottomMiddleStroke.makeConstraints { make in
            make
                .setBottom.equalToSuperView
                .setTrailing.equalToSuperView(calculateTrailing())
                .setLeading.equalToSuperView(calculateLeading())
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
    
    private func calculateLeading() -> CGFloat {
        if self.number == 5 {
            return -weight/1.5
        }
        return 0
    }
    
    private func calculateTrailing() -> CGFloat {
        if self.number == 2 {
            return weight/1.5
        }
        return 0
    }
    
}
