//
//  IndicatorView.swift
//  LootPuzzle
//
//  Created by Andrew Haentjens on 10/12/2017.
//  Copyright © 2017 Andrew Haentjens. All rights reserved.
//

import UIKit

class IndicatorView: UIView {
    
    override func draw(_ rect: CGRect) {
        let indicatorLayer = drawIndicatorLayer(in: rect)
        
        layer.addSublayer(indicatorLayer)
    }
    
    internal func drawIndicatorLayer(in rect: CGRect) -> CALayer {
        
        let margin: CGFloat = 8.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY),
                                      radius: (rect.width - (margin * 2)) / 2,
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2) / 24,
                                      clockwise: true)
        let circleLayer = CAShapeLayer()
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 8.0
        
        return circleLayer
        
    }
    
    func startRotating() {
        self.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
    }
    
    func endRotating() {
        
    }
    
}
