//
//  Extensions.swift
//  LootPuzzle
//
//  Created by Andrew Haentjens on 17/12/2017.
//  Copyright © 2017 Andrew Haentjens. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat.pi / 180
    }
    
    func toDegrees() -> CGFloat {
        return self * 180 / CGFloat.pi
    }
}
