//
//  ViewController.swift
//  LootPuzzle
//
//  Created by Andrew Haentjens on 10/12/2017.
//  Copyright © 2017 Andrew Haentjens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var indicatorView: IndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotate(indicatorView)
    }
    
    private func rotate(_ targetView: UIView, duration: Double = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
        }) { finished in
            self.rotate(targetView, duration: duration)
        }
    }
    

}
