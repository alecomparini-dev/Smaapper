//
//  GallowsDollProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import Foundation

protocol DollProtocol: ViewBuilder {
    func head()
    func torso()
    func rightArm()
    func leftArm()
    func rightLeg()
    func leftLeg()
}
