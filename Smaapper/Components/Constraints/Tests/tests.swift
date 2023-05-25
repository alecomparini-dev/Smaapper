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
        .equalTo(LabelBuilder("").view, .top, 10)
        
        .setBottom
        .equalTo(LabelBuilder("").view, .bottom )
    
    flow.apply()
    
}

//
func test_top_equalto_toAttibute() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .equalTo(LabelBuilder("").view, .bottom, 52)
        
        .setTop
        .equalTo(LabelBuilder("").view, .top)
    
    flow.apply()
}

func test_leading_equalto_toAttibute() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setLeading
        .equalTo(LabelBuilder("").view, .trailing, 25)
        
        .setLeading
        .equalTo(TextField(), .leading)
    
    flow.apply()
}


func test_trailing_equalto_toAttibute() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing.equalTo(LabelBuilder("").view, .leading, 55)
        .setTrailing.equalTo(LabelBuilder("").view, .trailing)
    
    flow.apply()
}


func test_bottom_equaltoSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setBottom.equalToSafeArea(111)
        .setBottom.equalToSafeArea
    
    flow.apply()
}


func test_top_equaltoSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTop.equalToSafeArea(222)
        .setTop.equalToSafeArea
    
    flow.apply()
}



func test_leading_equaltoSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setLeading.equalToSafeArea(3)
        .setLeading.equalToSafeArea
    
    flow.apply()
}


func test_trailing_equaltoSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing.equalToSafeArea(3)
        .setTrailing.equalToSafeArea
    
    flow.apply()
}


func test_bottom_equaltoSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setBottom
        .equalToSuperView(41)
    
        .setBottom
        .equalToSuperView
    
    flow.apply()
}


func test_top_equaltoSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .equalToSuperView(998)
    
        .setTop
        .equalToSuperView
    
    flow.apply()
}


func test_leading_equaltoSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setLeading
        .equalToSuperView(787)
    
        .setLeading
        .equalToSuperView
    
    flow.apply()
}


func test_trailing_equaltoSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing
        .equalToSuperView(332)
    
        .setTrailing
        .equalToSuperView
    
    flow.apply()
}



func test_width_equalTo() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .equalTo(LabelBuilder("").view)
    
    flow.apply()
    
}

func test_height_equalTo() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .equalTo(LabelBuilder("").view)
    
    flow.apply()
    
}


func test_width_equalToConstant() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .equalToConstant(123)
    
    flow.apply()
}


func test_height_equalToConstant() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .equalToConstant(321)
    
    flow.apply()
    
}


func test_width_equalToSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .equalToSafeArea
    
    flow.apply()
    
}


func test_height_equalToSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .equalToSafeArea
    
    flow.apply()
    
}


func test_width_equalToSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .equalToSuperView
    
    flow.apply()
}


func test_height_equalToSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .equalToSuperView
    
    flow.apply()
    
}


func test_horizontalX_equalTo() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHorizontalAlignmentX
        .equalTo(LabelBuilder("").view,5744)
    
        .setHorizontalAlignmentX
        .equalTo(LabelBuilder("").view)

    
    flow.apply()
    
}


func test_verticalY_equalTo() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setVerticalAlignmentY
        .equalTo(LabelBuilder("").view, 7799)
    
        .setVerticalAlignmentY
        .equalTo(LabelBuilder("").view)

    
    flow.apply()
    
}



func test_horizontalX_equalToSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHorizontalAlignmentX
        .equalToSafeArea(77)
    
        .setHorizontalAlignmentX
        .equalToSafeArea
    
    flow.apply()
    
}


func test_verticalY_equalToSafeArea() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setVerticalAlignmentY
        .equalToSafeArea(444)
    
        .setVerticalAlignmentY
        .equalToSafeArea
    
    flow.apply()
    
}


func test_horizontalX_equalToSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setHorizontalAlignmentX
        .equalToSuperView(123)
    
    
        .setHorizontalAlignmentX
        .equalToSuperView
    
    flow.apply()
    
}



func test_verticalY_equalToSuperView() {
    print("\n>>>>> \(#function)")
    let flow = StartOfConstraintsFlow(UIView())
        .setVerticalAlignmentY
        .equalToSuperView(8875)
    
        .setVerticalAlignmentY
        .equalToSuperView
    
    flow.apply()
    
}


func test_Position_Position_equalTo(){
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setLeading
        .equalTo(LabelBuilder("teste").view, 155)
    
        .setBottom
        .setTrailing
        .equalTo(LabelBuilder("").view)
    
    flow.apply()
    
}


func test_Position_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setWidth
        .equalTo(LabelBuilder("teste").view)
    
        .setTrailing
        .setHeight
        .equalTo(LabelBuilder("").view)
    
    flow.apply()
}


func test_Position_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setBottom
        .equalToSafeArea(115)
    
        .setTrailing
        .setLeading
        .equalToSafeArea
    
    flow.apply()
}


func test_Position_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setWidth
        .equalToSafeArea
    
    flow.apply()
}


func test_Size_Size_equalTo(){
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setHeight
        .equalTo(LabelBuilder("teste").view)
    
    flow.apply()
    
}


func test_Size_Size_equalToConstant(){
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setWidth
        .equalToConstant(997)
    
    flow.apply()
    
}


func test_Size_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setTop
        .equalTo(TextField())
    
    flow.apply()
    
}



func test_Size_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setHeight
        .equalToSafeArea
    
    flow.apply()
    
}


func test_Size_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setTrailing
        .equalToSafeArea
    
    flow.apply()
    
}


func test_Alignment_Alignment_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHorizontalAlignmentX
        .setVerticalAlignmentY
        .equalTo(LabelBuilder("").view)
    
    flow.apply()
    
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
        .equalTo(LabelBuilder("").view)
        
        .setTrailing
        .setLeading
        .setBottom
        .equalTo(LabelBuilder().view, 7799)

    flow.apply()
    
}


func test_Position_Position_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setLeading
        .setTrailing
        .setHeight
        .equalTo(LabelBuilder("äsdfasdf").view)
    
        .setTop
        .setBottom
        .setWidth
        .equalTo(LabelBuilder("").view)
        
    flow.apply()
    
}



func test_Position_Size_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTrailing
        .setWidth
        .setTop
        .equalTo(LabelBuilder("asdfasdf").view)
    
        .setTop
        .setHeight
        .setBottom
        .equalTo(LabelBuilder("").view)
        
    flow.apply()
    
}


func test_Position_Size_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setWidth
        .setHeight
        .equalTo(LabelBuilder("123456789").view)
    
        .setLeading
        .setHeight
        .setWidth
        .equalTo(TextFieldBuilder("asdfasdfasdf").view)
        
    flow.apply()
    
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

    flow.apply()
    
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
        
    flow.apply()
    
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
        
    flow.apply()
    
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
        
        
    flow.apply()
    
}


func test_Size_Size_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth.setHeight.setWidth.equalTo(LabelBuilder("nao deveria poder mas ok").view)
    
        .setWidth.setWidth.setHeight.equalTo(LabelBuilder().view)
        
    flow.apply()
    
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
        
    flow.apply()
    
}



func test_Size_Size_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setWidth
        .setTop
        .equalTo(LabelBuilder("top").view)
    
        .setWidth
        .setHeight
        .setTrailing
        .equalTo(LabelBuilder("trailing ").view)
        
    flow.apply()
    
}


func test_Size_Position_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setBottom
        .setWidth
        .equalTo(LabelBuilder("tetse").view)
    
        .setWidth
        .setLeading
        .setWidth
        .equalTo(LabelBuilder("labelmaroto").view)
        
    flow.apply()
    
}


func test_Size_Position_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setTop
        .setLeading
        .equalTo(LabelBuilder("teste5").view)
    
        .setWidth
        .setLeading
        .setTrailing
        .equalTo(LabelBuilder("teste7").view)
        
    flow.apply()
    
}


func test_Size_Size_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setHeight
        .setWidth
        .equalToSafeArea
    
    flow.apply()
    
}

func test_Size_Size_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setHeight
        .setTrailing
        .equalToSafeArea
    
    flow.apply()
    
}


func test_Size_Position_Size_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setLeading
        .setWidth
        .equalToSafeArea
        
    flow.apply()
    
}


func test_Size_Position_Position_equalToSafeArea() {
    let flow = StartOfConstraintsFlow(UIView())
        .setWidth
        .setTop
        .setLeading
        .equalToSafeArea
        
    flow.apply()
    
}


func test_Size_Position_Position_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setTop
        .setBottom
        .setHeight
        .equalTo(LabelBuilder("4 niveis").view)
        
    
        .setHeight
        .setLeading
        .setTrailing
        .setWidth
        .equalTo(LabelBuilder("4 niveis de novo").view)
        
    flow.apply()
    
}



func test_Position_Position_Position_Position_Size_Size_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setTop
        .setBottom
        .setLeading
        .setTrailing
        .setWidth
        .setHeight
        .equalTo(LabelBuilder("6 niveis !!!!").view)
    
        .setLeading
        .setTop
        .setTrailing
        .setBottom
        .setHeight
        .setWidth
        .equalTo(LabelBuilder("muito foda isso").view)
        
    flow.apply()
    
}


func test_Size_Size_Position_Position_Position_Position_equalTo() {
    let flow = StartOfConstraintsFlow(UIView())
        .setHeight
        .setWidth
        .setTop
        .setBottom
        .setLeading
        .setTrailing
        .equalTo(LabelBuilder("que top").view)
    
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
        .equalTo(LabelBuilder("muito foda dos fodasticos").view)
        
    flow.apply()
    
}


