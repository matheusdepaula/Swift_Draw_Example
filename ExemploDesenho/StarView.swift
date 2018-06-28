//
//  StarView.swift
//  ExemploDesenho
//
//  Created by Matheus de Paula on 25/06/18.
//  Copyright © 2018 Matheus de Paula. All rights reserved.
//

import UIKit

@IBDesignable
class StarView: UIView {
    
    @IBInspectable
    var numOfPoints: Int = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var innerRadius: CGFloat = 50.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var strokeColor: UIColor = UIColor.red

    
    private var starCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var starRadius: CGFloat {
        return min(bounds.width, bounds.height) / 2
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        strokeColor.setStroke()
        
        var angle = -CGFloat(CGFloat.pi / 2.0)
        let increment = (CGFloat.pi * 2.0) / CGFloat(numOfPoints)
        
        path.move(to: point(angle:angle, radius: starRadius, offset: starCenter))
        
        for _ in 1...numOfPoints {
            let innerPoint = point(angle: angle + increment / 2.0, radius: innerRadius, offset: starCenter)
            let outerPoint = point(angle: angle + increment, radius: starRadius, offset: starCenter)
            
            path.addLine(to: innerPoint)
            path.addLine(to: outerPoint)
            angle += increment
        }
        
        path.close()
        path.stroke()
    }
    
    func point(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
    }
    
}
