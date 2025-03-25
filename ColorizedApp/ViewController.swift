//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Konstantin on 24.03.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var setColorView: UIView!
    
    @IBOutlet var redPointLabel: UILabel!
    @IBOutlet var greenPointLabel: UILabel!
    @IBOutlet var bluePointLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorView.layer.cornerRadius = 10
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
    
    @IBAction func redSliderAction() {
        redPointLabel.text = redSlider.value.formatted(.number.precision(.fractionLength(2)))
        updateColorView()
    }
    @IBAction func greenSliderAction() {
        greenPointLabel.text = greenSlider.value.formatted(.number.precision(.fractionLength(2)))
        updateColorView()
    }
    @IBAction func blueSliderAction() {
        bluePointLabel.text = blueSlider.value.formatted(.number.precision(.fractionLength(2)))
        updateColorView()
    }
    
    private func updateColorView() {
        setColorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

