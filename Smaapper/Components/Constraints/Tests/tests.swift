//
//  tests.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 19/04/23.
//

import UIKit


func TESTESSSSSSSS() {
    
//         ############# UMA ETAPA SOMENTE !!!! ###################
    
    
//      - POSITION.equalTo('ELEM').toAttributo('ATTR').constant/nonConstant
    print("\n - POSITION.equalTo('ELEM').toAttributo('ATTR').constant/nonConstant ")
    test_top_equalto_toAttibute()
    test_bottom_equalto_toAttibute()
    test_leading_equalto_toAttibute()
    test_trailing_equalto_toAttibute()

//      - POSITION.equalToSafeArea().constant/nonConstant
    print("\n - POSITION.equalToSafeArea().constant/nonConstant ")
    test_bottom_equaltoSafeArea()
    test_top_equaltoSafeArea()
    test_leading_equaltoSafeArea()
    test_trailing_equaltoSafeArea()

//      - POSITION.equalToSuperView().constant/nonConstant
    print("\n - POSITION.equalToSuperView().constant/nonConstant ")
    test_bottom_equaltoSuperView()
    test_top_equaltoSuperView()
    test_leading_equaltoSuperView()
    test_trailing_equaltoSuperView()


//      - SIZE.equalTo("ELEM").nonConstant
    print("\n - SIZE.equalTo('ELEM').nonConstant ")
    test_width_equalTo()
    test_height_equalTo()

//      - SIZE.equalToConstant.constantObrigatorio
    print("\n - SIZE.equalToConstant.constantObrigatorio ")
    test_width_equalToConstant()
    test_height_equalToConstant()

//      - SIZE.equalToSafeArea().nonConstant
    print("\n - SIZE.equalToSafeArea().nonConstant ")
    test_width_equalToSafeArea()
    test_height_equalToSafeArea()

//      - SIZE.equalToSuperView().nonConstant
    print("\n - SIZE.equalToSuperView().nonConstant ")
    test_width_equalToSuperView()
    test_height_equalToSuperView()

//      - ALIGNMENT.equalTo("ELEM").constant/nonConstant
    print("\n ALIGNMENT.equalTo('ELEM').constant/nonConstant ")
    test_horizontalX_equalTo()
    test_verticalY_equalTo()


//      - ALIGNMENT.equalToSafeArea.constant/nonConstant
    print("\n - ALIGNMENT.equalToSafeArea.constant/nonConstant ")
    test_horizontalX_equalToSafeArea()
    test_verticalY_equalToSafeArea()


//      - ALIGNMENT.equalToSuperView.constant/nonConstant
    print("\n - ALIGNMENT.equalToSuperView.constant/nonConstant ")
    test_horizontalX_equalToSuperView()
    test_verticalY_equalToSuperView()



    print("\n\n\n    ############# DUAS ETAPAS !!!! ###################  \n")


//      - POSITION.POSITION.equalTo("ELEM").constant/nonConstant
    print("\n - POSITION.POSITION.equalTo('ELEM').constant/nonConstant ")
    test_Position_Position_equalTo()

//      - POSITION.SIZE.equalTo("ELEM").nonConstant
    print("\n - POSITION.SIZE.equalTo('ELEM').nonConstant ")
    test_Position_Size_equalTo()

//      - POSITION.POSITION.equalToSafeArea.constant/nonConstant
    print("\n - POSITION.POSITION.equalToSafeArea.constant/nonConstant ")
    test_Position_Position_equalToSafeArea()


//      - POSITION.SIZE.equalToSafeArea.nonConstant
    print("\n - POSITION.SIZE.equalToSafeArea.nonConstant ")
    test_Position_Size_equalToSafeArea()

//      - SIZE.SIZE.equalTo("ELEM").nonConstant
    print("\n - SIZE.SIZE.equalTo('ELEM).nonConstant ")
    test_Size_Size_equalTo()

//      - SIZE.SIZE.equalConstant.constantObrigatorio
    print("\n - SIZE.SIZE.equalConstant.constantObrigatorio ")
    test_Size_Size_equalToConstant()

//      - SIZE.POSITION.equalTo("ELEM").nonConstant
    print("\n - SIZE.POSITION.equalTo('ELEM).nonConstant ")
    test_Size_Position_equalTo()

//      - SIZE.SIZE.equalToSafeArea.nonConstant
    print("\n - SIZE.SIZE.equalToSafeArea.nonConstant ")
    test_Size_Size_equalToSafeArea()

//      - SIZE.POSITION.equalToSafeArea.nonConstant
    print("\n - SIZE.POSITION.equalToSafeArea.nonConstant ")
    test_Size_Position_equalToSafeArea()

//      - ALIGNMENT.ALIGNMENT.equalTo("ELEM").nonConstant
    print("\n - ALIGNMENT.ALIGNMENT.equalTo('ELEM').nonConstant ")
    test_Alignment_Alignment_equalTo()

//        OK - POSITION.ALIGNMENT.equalTo("ELEM").nonConstant [NÃO PERMITIDO]
//        OK - SIZE.ALIGNMENT.equalTo("ELEM").nonConstant [NÃO PERMITIDO]
//


    print("\n\n\n    ############# TRES ETAPAS OU MAIS !!!! ###################  \n")

//      - POSITION.POSITION.POSITION.equalTo("ELEM").constant/nonConstant
    print("\n - POSITION.POSITION.POSITION.equalTo('ELEM').constant/nonConstant ")
    test_Position_Position_Position_equalTo()

//      - POSITION.POSITION.SIZE.equalTo("ELEM").nonConstant
    print("\n - POSITION.POSITION.SIZE.equalTo('ELEM').nonConstant ")
    test_Position_Position_Size_equalTo()

//      - POSITION.SIZE.POSITION.equalTo("ELEM").nonConstant
    print("\n - POSITION.SIZE.POSITION.equalTo('ELEM').nonConstant ")
    test_Position_Size_Position_equalTo()

//      - POSITION.SIZE.SIZE.equalTo("ELEM").nonConstant
    print("\n - POSITION.SIZE.SIZE.equalTo('ELEM').nonConstant ")
    test_Position_Size_Size_equalTo()


//      - POSITION.POSITION.POSITION.equalToSafeArea().constant/nonConstant
    print("\n - POSITION.POSITION.POSITION.equalToSafeArea().constant/nonConstant ")
    test_Position_Position_Position_equalToSafeArea()

//      - POSITION.POSITION.SIZE.equalToSafeArea().nonConstant
    print("\n - POSITION.POSITION.SIZE.equalToSafeArea().nonConstant ")
    test_Position_Position_Size_equalToSafeArea()

//      - POSITION.SIZE.POSITION.equalToSafeArea().nonConstant
    print("\n - POSITION.SIZE.POSITION.equalToSafeArea().nonConstant ")
    test_Position_Size_Position_equalToSafeArea()

//      - POSITION.SIZE.SIZE.equalToSafeArea().nonConstant
    print("\n - POSITION.SIZE.SIZE.equalToSafeArea().nonConstant ")
    test_Position_Size_Size_equalToSafeArea()


//      - SIZE.SIZE.SIZE.equalTo("ELEM").noConstant
    print("\n - SIZE.SIZE.SIZE.equalTo('ELEM').noConstant ")
    test_Size_Size_Size_equalTo()

//      - SIZE.SIZE.SIZE.equalToConstant.constantObrigatorio
    print("\n - SIZE.SIZE.SIZE.equalToConstant.constantObrigatorio ")
    test_Size_Size_Size_equalToConstant()


//      - SIZE.SIZE.POSITION.equalTo("ELEM").nonConstant
    print("\n - SIZE.SIZE.POSITION.equalTo('ELEM').nonConstant ")
    test_Size_Size_Position_equalTo()

//      - SIZE.POSITION.SIZE.equalTo("ELEM").nonConstant
    print("\n - SIZE.POSITION.SIZE.equalTo(ELEM).nonConstant ")
    test_Size_Position_Size_equalTo()

//      - SIZE.POSITION.POSITION.equalTo("ELEM").nonConstant
    print("\n - SIZE.POSITION.POSITION.equalTo(ELEM).nonConstant ")
    test_Size_Position_Position_equalTo()


//      - SIZE.SIZE.SIZE.equalToSafeArea().nonConstant
    print("\n - SIZE.SIZE.SIZE.equalToSafeArea().nonConstant ")
    test_Size_Size_Size_equalToSafeArea()


//      - SIZE.SIZE.POSITION.equalToSafeArea().nonConstant
    print("\n - SIZE.SIZE.POSITION.equalToSafeArea().nonConstant ")
    test_Size_Size_Position_equalToSafeArea()

//      - SIZE.POSITION.SIZE.equalToSafeArea().nonConstant
    print("\n - SIZE.POSITION.SIZE.equalToSafeArea().nonConstant")
    test_Size_Position_Size_equalToSafeArea()

//      - SIZE.POSITION.POSITION.equalToSafeArea().nonConstant
    print("\n - SIZE.POSITION.POSITION.equalToSafeArea().nonConstant")
    test_Size_Position_Position_equalToSafeArea()


//      - SIZE.POSITION.POSITION.SIZE.equalTo().nonConstant
    print("\n - SIZE.POSITION.POSITION.SIZE.equalTo().nonConstant")
    test_Size_Position_Position_Size_equalTo()

//      - POSITION.POSITION.POSITION.POSITION.SIZE.SIZE.equalTo().nonConstant
    print("\n - POSITION.POSITION.POSITION.POSITION.SIZE.SIZE.equalTo().nonConstant")
    test_Position_Position_Position_Position_Size_Size_equalTo()


//      - SIZE.SIZE.POSITION.POSITION.POSITION.POSITION.equalTo().nonConstant
    print("\n - SIZE.SIZE.POSITION.POSITION.POSITION.POSITION.equalTo().nonConstant")
    test_Size_Size_Position_Position_Position_Position_equalTo()


    
    
    
}


func test_bottom_equalto_toAttibute() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setBottom
        .equalTo(Label(""), .top, 10)
        
        .setBottom
        .equalTo(Label(""), .bottom )
    
    flow.applyConstraint()
    
}

//
func test_top_equalto_toAttibute() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .equalTo(Label(""), .bottom, 52)
        
        .setTop
        .equalTo(Label(""), .top)
    
    flow.applyConstraint()
}

func test_leading_equalto_toAttibute() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setLeading
        .equalTo(Label(""), .trailing, 25)
        
        .setLeading
        .equalTo(TextField(), .leading)
    
    flow.applyConstraint()
}


func test_trailing_equalto_toAttibute() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing.equalTo(Label(""), .leading, 55)
        .setTrailing.equalTo(Label(""), .trailing)
    
    flow.applyConstraint()
}


func test_bottom_equaltoSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setBottom.equalToSafeArea(111)
        .setBottom.equalToSafeArea
    
    flow.applyConstraint()
}


func test_top_equaltoSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTop.equalToSafeArea(222)
        .setTop.equalToSafeArea
    
    flow.applyConstraint()
}



func test_leading_equaltoSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setLeading.equalToSafeArea(3)
        .setLeading.equalToSafeArea
    
    flow.applyConstraint()
}


func test_trailing_equaltoSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing.equalToSafeArea(3)
        .setTrailing.equalToSafeArea
    
    flow.applyConstraint()
}


func test_bottom_equaltoSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setBottom
        .equalToSuperView(41)
    
        .setBottom
        .equalToSuperView
    
    flow.applyConstraint()
}


func test_top_equaltoSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .equalToSuperView(998)
    
        .setTop
        .equalToSuperView
    
    flow.applyConstraint()
}


func test_leading_equaltoSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setLeading
        .equalToSuperView(787)
    
        .setLeading
        .equalToSuperView
    
    flow.applyConstraint()
}


func test_trailing_equaltoSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing
        .equalToSuperView(332)
    
        .setTrailing
        .equalToSuperView
    
    flow.applyConstraint()
}



func test_width_equalTo() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .equalTo(Label(""))
    
    flow.applyConstraint()
    
}

func test_height_equalTo() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .equalTo(Label(""))
    
    flow.applyConstraint()
    
}


func test_width_equalToConstant() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .equalToConstant(123)
    
    flow.applyConstraint()
}


func test_height_equalToConstant() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .equalToConstant(321)
    
    flow.applyConstraint()
    
}


func test_width_equalToSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .equalToSafeArea
    
    flow.applyConstraint()
    
}


func test_height_equalToSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .equalToSafeArea
    
    flow.applyConstraint()
    
}


func test_width_equalToSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .equalToSuperView
    
    flow.applyConstraint()
}


func test_height_equalToSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .equalToSuperView
    
    flow.applyConstraint()
    
}


func test_horizontalX_equalTo() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHorizontalAlignmentX
        .equalTo(Label(""),5744)
    
        .setHorizontalAlignmentX
        .equalTo(Label(""))

    
    flow.applyConstraint()
    
}


func test_verticalY_equalTo() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setVerticalAlignmentY
        .equalTo(Label(""), 7799)
    
        .setVerticalAlignmentY
        .equalTo(TextFieldImage(UIImage(systemName: "trash")!))

    
    flow.applyConstraint()
    
}



func test_horizontalX_equalToSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHorizontalAlignmentX
        .equalToSafeArea(77)
    
        .setHorizontalAlignmentX
        .equalToSafeArea
    
    flow.applyConstraint()
    
}


func test_verticalY_equalToSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setVerticalAlignmentY
        .equalToSafeArea(444)
    
        .setVerticalAlignmentY
        .equalToSafeArea
    
    flow.applyConstraint()
    
}


func test_horizontalX_equalToSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHorizontalAlignmentX
        .equalToSuperView(123)
    
    
        .setHorizontalAlignmentX
        .equalToSuperView
    
    flow.applyConstraint()
    
}



func test_verticalY_equalToSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setVerticalAlignmentY
        .equalToSuperView(8875)
    
        .setVerticalAlignmentY
        .equalToSuperView
    
    flow.applyConstraint()
    
}


func test_Position_Position_equalTo(){
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setLeading
        .equalTo(Label("teste"), 155)
    
        .setBottom
        .setTrailing
        .equalTo(Label(""))
    
    flow.applyConstraint()
    
}


func test_Position_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setWidth
        .equalTo(Label("teste"))
    
        .setTrailing
        .setHeight
        .equalTo(Label(""))
    
    flow.applyConstraint()
}


func test_Position_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setBottom
        .equalToSafeArea(115)
    
        .setTrailing
        .setLeading
        .equalToSafeArea
    
    flow.applyConstraint()
}


func test_Position_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setWidth
        .equalToSafeArea
    
    flow.applyConstraint()
}


func test_Size_Size_equalTo(){
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setHeight
        .equalTo(Label("teste"))
    
    flow.applyConstraint()
    
}


func test_Size_Size_equalToConstant(){
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setWidth
        .equalToConstant(997)
    
    flow.applyConstraint()
    
}


func test_Size_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setTop
        .equalTo(TextField())
    
    flow.applyConstraint()
    
}



func test_Size_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setHeight
        .equalToSafeArea
    
    flow.applyConstraint()
    
}


func test_Size_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setTrailing
        .equalToSafeArea
    
    flow.applyConstraint()
    
}


func test_Alignment_Alignment_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHorizontalAlignmentX
        .setVerticalAlignmentY
        .equalTo(Label(""))
    
    flow.applyConstraint()
    
}



func test_Position_Position_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setBottom
        .setLeading
        .equalTo(TextField(), 710)
    
        .setLeading
        .setTop
        .setTrailing
        .equalTo(Label(""))
        
        .setTrailing
        .setLeading
        .setBottom
        .equalTo(Label(), 7799)

    flow.applyConstraint()
    
}


func test_Position_Position_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setLeading
        .setTrailing
        .setHeight
        .equalTo(Label("äsdfasdf"))
    
        .setTop
        .setBottom
        .setWidth
        .equalTo(Label(""))
        
    flow.applyConstraint()
    
}



func test_Position_Size_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing
        .setWidth
        .setTop
        .equalTo(Label("asdfasdf"))
    
        .setTop
        .setHeight
        .setBottom
        .equalTo(Label(""))
        
    flow.applyConstraint()
    
}


func test_Position_Size_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setWidth
        .setHeight
        .equalTo(Label("123456789"))
    
        .setLeading
        .setHeight
        .setWidth
        .equalTo(TextField("asdfasdfasdf"))
        
    flow.applyConstraint()
    
}


func test_Position_Position_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing
        .setLeading
        .setBottom
        .equalToSafeArea(5577)
    
    
        .setTop
        .setLeading
        .setTrailing
        .equalToSafeArea
        
    
        .setTop
        .setBottom
        .setLeading
        .equalToSafeArea(77555)

    flow.applyConstraint()
    
}



func test_Position_Position_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setLeading
        .setTrailing
        .setHeight
        .equalToSafeArea
    
        .setTop
        .setLeading
        .setWidth
        .equalToSafeArea
        
    flow.applyConstraint()
    
}


func test_Position_Size_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing
        .setWidth
        .setTop
        .equalToSafeArea
    
        .setBottom
        .setHeight
        .setTop
        .equalToSafeArea
        
    flow.applyConstraint()
    
}


func test_Position_Size_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setWidth
        .setHeight
        .equalToSafeArea
    
        .setLeading
        .setHeight
        .setWidth
        .equalToSafeArea
        
        
    flow.applyConstraint()
    
}


func test_Size_Size_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth.setHeight.setWidth.equalTo(Label("nao deveria poder mas ok"))
    
        .setWidth.setWidth.setHeight.equalTo(Label())
        
    flow.applyConstraint()
    
}


func test_Size_Size_Size_equalToConstant() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setHeight
        .setWidth
        .equalToConstant(465222)
    
        .setHeight
        .setWidth
        .setHeight
        .equalToConstant(77885222)
        
    flow.applyConstraint()
    
}



func test_Size_Size_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setWidth
        .setTop
        .equalTo(Label("top"))
    
        .setWidth
        .setHeight
        .setTrailing
        .equalTo(Label("trailing "))
        
    flow.applyConstraint()
    
}


func test_Size_Position_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setBottom
        .setWidth
        .equalTo(Label("tetse"))
    
        .setWidth
        .setLeading
        .setWidth
        .equalTo(Label("labelmaroto"))
        
    flow.applyConstraint()
    
}


func test_Size_Position_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setTop
        .setLeading
        .equalTo(Label("teste5"))
    
        .setWidth
        .setLeading
        .setTrailing
        .equalTo(Label("teste7"))
        
    flow.applyConstraint()
    
}


func test_Size_Size_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setHeight
        .setWidth
        .equalToSafeArea
    
    flow.applyConstraint()
    
}

func test_Size_Size_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setHeight
        .setTrailing
        .equalToSafeArea
    
    flow.applyConstraint()
    
}


func test_Size_Position_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setLeading
        .setWidth
        .equalToSafeArea
        
    flow.applyConstraint()
    
}


func test_Size_Position_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setTop
        .setLeading
        .equalToSafeArea
        
    flow.applyConstraint()
    
}


func test_Size_Position_Position_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setTop
        .setBottom
        .setHeight
        .equalTo(Label("4 niveis"))
        
    
        .setHeight
        .setLeading
        .setTrailing
        .setWidth
        .equalTo(Label("4 niveis de novo"))
        
    flow.applyConstraint()
    
}



func test_Position_Position_Position_Position_Size_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setBottom
        .setLeading
        .setTrailing
        .setWidth
        .setHeight
        .equalTo(Label("6 niveis !!!!"))
    
        .setLeading
        .setTop
        .setTrailing
        .setBottom
        .setHeight
        .setWidth
        .equalTo(Label("muito foda isso"))
        
    flow.applyConstraint()
    
}


func test_Size_Size_Position_Position_Position_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setWidth
        .setTop
        .setBottom
        .setLeading
        .setTrailing
        .equalTo(Label("que top"))
    
        .setWidth
        .setHeight
        .setTrailing
        .setLeading
        .setBottom
        .setTop
        .equalToSafeArea
        
        .setWidth
        .setHeight
        .setTrailing
        .setLeading
        .setBottom
        .setTop
        .equalTo(Label("muito foda dos fodasticos"))
        
    flow.applyConstraint()
    
}


