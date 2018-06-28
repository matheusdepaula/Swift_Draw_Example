//
//  StarViewController.swift
//  ExemploDesenho
//
//  Created by Matheus de Paula on 28/06/18.
//  Copyright © 2018 Matheus de Paula. All rights reserved.
//

import UIKit

class StarViewController: UIViewController {

    @IBOutlet weak var starView: StarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func innerValue(_ sender: UISlider) {
        starView.innerRadius = CGFloat(sender.value)
    }
    
    @IBAction func pointsValue(_ sender: UIStepper) {
        starView.numOfPoints = Int(sender.value)
    }
}
