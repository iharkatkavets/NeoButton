//
//  ViewController.swift
//  NeoButton
//
//  Created by Igor Kotkovets on 02/20/2020.
//  Copyright (c) 2020 Igor Kotkovets. All rights reserved.
//

import UIKit
import NeoButton

class ViewController: UIViewController {
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var neoButton: NeoButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func radiusDidChange(_ sender: UISlider) {
        neoButton.radius = CGFloat(sender.value)
    }

    @IBAction func distanceDidChange(_ sender: UISlider) {
        neoButton.distance = CGFloat(sender.value)
    }

    @IBAction func blurDidChange(_ sender: UISlider) {
        neoButton.blur = CGFloat(sender.value)
    }

    @IBAction func intensityDidChange(_ sender: UISlider) {
        neoButton.intensity = sender.value
    }
}

