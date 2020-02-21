//
//  ViewController.swift
//  NeoButton
//
//  Created by Igor Kotkovets on 02/20/2020.
//  Copyright (c) 2020 Igor Kotkovets. All rights reserved.
//

import UIKit
import NeoButton
import os.log

class ViewController: UIViewController {
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var blurSlider: UISlider!
    @IBOutlet weak var intensitySlider: UISlider!
    @IBOutlet weak var neoButton: NeoButton!
    let outLog = OSLog(subsystem: "NeoButton", category: String(describing: self))
    @IBOutlet weak var distanceValueLabel: UILabel!
    @IBOutlet weak var intensityValueLabel: UILabel!
    @IBOutlet weak var blurValueLabel: UILabel!
    @IBOutlet weak var radiusValueLabel: UILabel!
    @IBOutlet var buttonColors: [UIButton]!
    @IBOutlet var viewControllerColors: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonColors.forEach { (btn) in
            btn.addTarget(self, action: #selector(didSelectNeoButtonColor), for: .touchDown)
        }

        viewControllerColors.forEach { (btn) in
            btn.addTarget(self, action: #selector(didSelectViewControllerColor), for: .touchDown)
        }
    }

    @IBAction func didSelectNeoButtonColor(_ button: UIButton) {
        self.neoButton.color = button.backgroundColor!
    }

    @IBAction func didSelectViewControllerColor(_ button: UIButton) {
        self.view.backgroundColor = button.backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        radiusDidChange(radiusSlider)
        distanceDidChange(distanceSlider)
        blurDidChange(blurSlider)
        intensityDidChange(intensitySlider)
    }

    @IBAction func radiusDidChange(_ sender: UISlider) {
        neoButton.radius = CGFloat(sender.value)
        radiusValueLabel.text = String(format: "Radius: %.2f", neoButton.radius)
    }

    @IBAction func distanceDidChange(_ sender: UISlider) {
        neoButton.distance = CGFloat(sender.value)
        distanceValueLabel.text = String(format: "Distance: %.2f", neoButton.distance)
        blurValueLabel.text = String(format: "Blur: %.2f", neoButton.blur)
    }

    @IBAction func blurDidChange(_ sender: UISlider) {
        neoButton.blur = CGFloat(sender.value)
        blurValueLabel.text = String(format: "Blur: %.2f", neoButton.blur)
    }

    @IBAction func intensityDidChange(_ sender: UISlider) {
        neoButton.intensity = sender.value
        intensityValueLabel.text = String(format: "Intensity: %.2f", neoButton.intensity)
    }
}

