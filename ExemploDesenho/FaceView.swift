//
//  FaceView.swift
//  ExemploDesenho
//
//  Created by Matheus de Paula on 14/06/2018.
//  Copyright © 2018 Matheus de Paula. All rights reserved.
//

import UIKit

@IBDesignable

class FaceView: UIView {
    
    @IBInspectable
    var strokeColor: UIColor = UIColor.red
    
    var mounth: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var eyesOpen: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private enum Eye {
        case left
        case right
    }
    
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMounthWidth: CGFloat = 1
        static let skullRadiusToMounthHeight: CGFloat = 3
        static let skullRadiusToMounthOffset: CGFloat = 3
    }

    override func draw(_ rect: CGRect) {
        strokeColor.setStroke()
        
        //Circulo
        pathForSkull().stroke()
        
        //Olho esquerdo
        path(forEye: .left).stroke()
        
        //Olho direito
        path(forEye: .right).stroke()
        
        //Boca
        pathForMouth().stroke()
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * 0.8
    }
    
    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        
        path.lineWidth = 3
        return path
    }
    
    private func path(forEye eye: Eye) -> UIBezierPath {
        
        func centerOf(eye: Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            
            return eyeCenter
        }
        
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOf(eye: eye)
        
        var path = UIBezierPath()
        
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        } else {
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        
        path.lineWidth = 3
        
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        
        let mouthWidth = skullRadius / Ratios.skullRadiusToMounthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMounthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMounthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mounth, 1))) * mouthHeight
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3, y: start.y + smileOffset)
        
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 3
        
        return path
    }
}
