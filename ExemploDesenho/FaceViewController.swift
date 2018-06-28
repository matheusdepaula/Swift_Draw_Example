//
//  FaceViewController.swift
//  ExemploDesenho
//
//  Created by Matheus de Paula on 26/06/18.
//  Copyright © 2018 Matheus de Paula. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    
    @IBOutlet weak var faceView: FaceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        faceView.mounth = Double(sender.value)
    }
    
    @IBAction func smileSwitch(_ sender: UISwitch) {
        faceView.eyesOpen = sender.isOn
    }
    
}
