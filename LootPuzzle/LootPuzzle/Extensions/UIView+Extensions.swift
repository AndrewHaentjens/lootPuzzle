//
//  UIView+Extensions.swift
//  LootPuzzle
//
//  Created by Andrew Haentjens on 10/12/2017.
//  Copyright © 2017 Andrew Haentjens. All rights reserved.
//

import UIKit

extension UIView {
    
    func rotate360Degrees(duration: CFTimeInterval = 3) {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat.pi * 2
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        
        self.layer.add(rotateAnimation, forKey: nil)
        
    }
    
    func getCurrentRotation() -> CGFloat? {
        
            return nil
    }
    
}
