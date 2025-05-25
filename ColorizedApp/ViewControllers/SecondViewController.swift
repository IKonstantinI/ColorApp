//
//  SecondViewController.swift
//  ColorizedApp
//
//  Created by Konstantin on 09.05.2025.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setBackground(color: UIColor)
}

final class SecondViewController: UIViewController {
    
    var currentColor: UIColor = .red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = currentColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as? SettingsViewController
        settingsVC?.mainViewColor = currentColor
        settingsVC?.delegate = self
    }
}

//MARK: - SettingsViewControllerDelegate
extension SecondViewController: SettingsViewControllerDelegate {
    func setBackground(color: UIColor) {
        currentColor = color
        view.backgroundColor = color
    }
}
