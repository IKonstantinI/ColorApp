//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Konstantin on 24.03.2025.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet private var colorView: UIView!
    
    @IBOutlet private var redPointLabel: UILabel!
    @IBOutlet private var greenPointLabel: UILabel!
    @IBOutlet private var bluePointLabel: UILabel!
    
    @IBOutlet private var redSlider: UISlider!
    @IBOutlet private var greenSlider: UISlider!
    @IBOutlet private var blueSlider: UISlider!
    
    @IBOutlet private var redTextField: UITextField!
    @IBOutlet private var greenTextField: UITextField!
    @IBOutlet private var blueTextField: UITextField!
    
    private var redValue: Float = 0.0
    private var greenValue: Float = 0.0
    private var blueValue: Float = 0.0
    
    weak var delegate: SettingsViewControllerDelegate?
    weak var mainViewColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        parseColor(mainViewColor ?? .systemBackground)
        updateAllViews()
        
        setupSliders()
        setupKeyboardToolbar()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValue = redSlider.value
        case greenSlider:
            greenValue = greenSlider.value
        default:
            blueValue = blueSlider.value
        }
        updateAllViews()
    }
    
    @IBAction func doneButtonTapped() {
        delegate?.setBackground(color: colorView.backgroundColor ?? .green)
        navigationController?.popViewController(animated: true)
    }
    
    private func parseColor(_ color: UIColor) {
        let ciColor = CIColor(color: color)
        
        redValue = Float(ciColor.red)
        greenValue = Float(ciColor.green)
        blueValue = Float(ciColor.blue)
    }
    
    private func updateAllViews() {
        updateColorView()
        updateValueLabels()
        updateSliders()
        updateTextFields()
    }
    
}

//MARK: - Setup Sliders
extension SettingsViewController {
    private func setupSliders() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
}

//MARK: - Setup Keyboard
extension SettingsViewController {
    private func setupKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            primaryAction: UIAction { [weak self] _ in
                self?.view.endEditing(true)
            }
        )
        
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        redTextField.inputAccessoryView = toolbar
        greenTextField.inputAccessoryView = toolbar
        blueTextField.inputAccessoryView = toolbar
    }
}

//MARK: - Alert Controller
extension SettingsViewController {
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.updateTextFields()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text,
                let value = Float(text.replacingOccurrences(of: ",", with: ".")),
              (0...1).contains(value) else {
            showAlert(withTitle: "Ошибка", andMessage: "Введите число 0.00 до 1.00")
            return
        }
        
        switch textField {
        case redTextField: redValue = value
        case greenTextField: greenValue = value
        default: blueValue = value
        }
        
        updateAllViews()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Update Views
extension SettingsViewController {
    private func updateColorView() {
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = UIColor(
            red: CGFloat(redValue),
            green: CGFloat(greenValue),
            blue: CGFloat(blueValue),
            alpha: 1
        )
    }
    
    private func updateValueLabels() {
        redPointLabel.text = String(format: "%.2f", redValue)
        greenPointLabel.text = String(format: "%.2f", greenValue)
        bluePointLabel.text = String(format: "%.2f", blueValue)
    }
    
    private func updateSliders() {
        redSlider.value = redValue
        greenSlider.value = greenValue
        blueSlider.value = blueValue
    }
    
    private func updateTextFields() {
        redTextField.text = String(format: "%.2f", redValue)
        greenTextField.text = String(format: "%.2f", greenValue)
        blueTextField.text = String(format: "%.2f", blueValue)
    }
}

