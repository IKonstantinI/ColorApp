//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Konstantin on 24.03.2025.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private var colorView: UIView!
    
    @IBOutlet private var redPointLabel: UILabel!
    @IBOutlet private var greenPointLabel: UILabel!
    @IBOutlet private var bluePointLabel: UILabel!
    
    @IBOutlet private var redSlider: UISlider!
    @IBOutlet private var greenSlider: UISlider!
    @IBOutlet private var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorViewSetup()
        valueLabelSetup()
        sliderSetup()
    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redPointLabel.text = string(from: redSlider)
        case greenSlider:
            greenPointLabel.text = string(from: greenSlider)
        default:
            bluePointLabel.text = string(from: blueSlider)
        }
        colorViewSetup()
    }
    
    private func valueLabelSetup() {
        redPointLabel.text = string(from: redSlider)
        greenPointLabel.text = string(from: greenSlider)
        bluePointLabel.text = string(from: blueSlider)
    }
   
    private func sliderSetup() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
    
    private func colorViewSetup() {
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
}
