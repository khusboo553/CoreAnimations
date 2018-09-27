//
//  UIButtonX.swift
//  PulseAnimation
//
//  Created by GLB-311-PC on 26/09/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit
//allow changes in storyboard
@IBDesignable
class UIButtonX :UIButton {
    enum FromDirection:Int {
        case Top = 0
        case Right = 1
        case Bottom = 2
        case Left =  3
    }
    var direction:FromDirection = .Left
    var alphaBefore:CGFloat = 1
    
    //IBInspectable==>show changes in interfacebuilder
    @IBInspectable var animate:Bool = false
    @IBInspectable var cornerRadious:Int = 2
    @IBInspectable var borderColor:UIColor = UIColor.white
    @IBInspectable var animateDelay:Double = 0.2
    @IBInspectable var animateFrom:Int {
        get {
            return direction.rawValue
        }
        
        set(directionIndex){
            direction = FromDirection(rawValue:directionIndex) ?? .Left
        }
    }
}
