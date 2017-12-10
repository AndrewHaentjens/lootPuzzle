//
//  CircleView.swift
//  LootPuzzle
//
//  Created by Andrew Haentjens on 10/12/2017.
//  Copyright © 2017 Andrew Haentjens. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    override func draw(_ rect: CGRect) {
        let mainCircleLayer = drawCircleLayer(in: rect)
        
        layer.addSublayer(mainCircleLayer)
    }
    
    internal func drawCircleLayer(in rect: CGRect) -> CALayer {
        
        let margin: CGFloat = 8.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY),
                                      radius: (rect.width - (margin * 2)) / 2,
                                      startAngle: CGFloat(0),
                                      endAngle:CGFloat(Double.pi * 2),
                                      clockwise: true)
        
        let circleLayer = CAShapeLayer()
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.green.cgColor
        circleLayer.strokeColor = UIColor.green.cgColor
        circleLayer.lineWidth = 1.0
        
        return circleLayer
        
    }
    
}
