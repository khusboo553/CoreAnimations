//
//  colorClass.swift
//  PulseAnimation
//
//  Created by GLB-311-PC on 26/09/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
        return UIColor(red:r/255,green:g/255,blue:b/255,alpha:1)
    }
    
    static let backgroundColor = UIColor.rgb(r:21, g:22, b:33)
    static let outlineStrokeColor = UIColor.rgb(r:234, g:46, b:111)
    static let trackStrokeColor = UIColor.rgb(r:56, g:25, b:49)
    static let pulsatingColor = UIColor.rgb(r:86, g:30, b:63)
//    static let outColor=GradientView.sharedInstanceGradient.updateStrokeColor(first:UIColor.blue, second:UIColor.white)
}
extension CALayer {
    
    func addGradienBorder(colors:[UIColor],width:CGFloat = 1) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  CGRect(origin:.zero, size: self.bounds.size)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = colors.map({$0.cgColor})
        let rect = CGRect(origin:CGPoint.zero,size:CGSize(width:self.bounds.width,height: self.bounds.height))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
         //for circle corners
        shapeLayer.path=UIBezierPath(roundedRect: rect, cornerRadius: rect.width/2).cgPath
        //for square corners
//        shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer
        
        self.addSublayer(gradientLayer)
        
        
        //circle animation
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.isRemovedOnCompletion = true
        // Set the animation duration appropriately
        animation.duration = 2
        
        // Animate from 0.010 (no circle) to 0.99 (full circle)
        animation.fromValue = 0.0
        animation.toValue = 1.0
        
        // Do an easeout. Don't know how to do a spring instead
        //animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // Set the circleLayer's strokeEnd property to 0.99 now so that it's the
        // right value when the animation ends.
        let circleMask = shapeLayer
        circleMask.strokeEnd = 1.0
        
        // Do the actual animation
        circleMask.removeAllAnimations()
        circleMask.add(animation, forKey: "animateCircle")
//        animateCircle(duration:0.2)
        
    }
   
}
