//
//  GradientView.swift
//  PulseAnimation
//
//  Created by GLB-311-PC on 26/09/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    static let sharedInstanceGradient = GradientView()
    @IBInspectable var firstColor:UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var secondColor:UIColor = UIColor.clear {
        didSet{
             updateView()
        }
    }
    
    //it is uiview layerclass
    override class var layerClass:AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func  updateView(){
        let layer = self.layer as!CAGradientLayer
        layer.colors = [firstColor.cgColor,secondColor.cgColor]
    }

}
