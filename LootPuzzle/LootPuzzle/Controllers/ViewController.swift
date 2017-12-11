//
//  ViewController.swift
//  LootPuzzle
//
//  Created by Andrew Haentjens on 10/12/2017.
//  Copyright © 2017 Andrew Haentjens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tap: UITapGestureRecognizer!
    @IBOutlet weak var indicatorView: IndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        indicatorView.rotate360Degrees()
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        print("Degrees on tap: \(indicatorView.getCurrentRotation())")
    }
    
}
